import fetch from 'isomorphic-fetch'

export enum CommitState {
  error = 'error',
  failure = 'failure',
  pending = 'pending',
  success = 'success'
}

export type GithubStatus = {
  url: string,
  avatar_url: string,
  id: number,
  node_id: string,
  state: CommitState,
  description: string,
  target_url: string,
  context: string,
  created_at: string,
  updated_at: string,
}

export type CommitStatus = {
  state: CommitState,
  target_url: string,
  description: string,
  context: string,
}

function env(name: string, required: true): string
function env(name: string, required: boolean): string | undefined {
  if (required && typeof process.env[name] !== 'string') {
    throw new Error(`missing environment variable "${name}"`)
  }

  return process.env[name]
}

export async function updateCommitStatus(newStatus: CommitStatus) {
  const GITHUB_TOKEN = env('GITHUB_TOKEN', true)
  const GITHUB_REPOSITORY = env('GITHUB_REPOSITORY', true)
  const GITHUB_SHA = env('GITHUB_SHA', true)

  const [ owner, repo ] = GITHUB_REPOSITORY.split('/')
  const sha = GITHUB_SHA

  const response = await fetch(
    `https://api.github.com/repos/${owner}/${repo}/commits/${sha}/status`,
    {
      method: 'GET',
      headers: {
        'Accept': 'application/vnd.github.v3+json',
        'Authorization': `token ${GITHUB_TOKEN}`
      }
    }
  )

  const body = await response.json()
  const current: GithubStatus  = body.statuses.find((github: GithubStatus) => {
    return github.context === newStatus.context && github.target_url === newStatus.target_url
  })

  if (current) {
    if (current.state === CommitState.success) {
      console.log(`skipinig update: status already success`)
      return null
    }

    if (current.state === newStatus.state) {
      console.log(`skipinig update: status didn't change (${newStatus.state})`)
      return null
    }

    if (!newStatus.description && current.description) {
      newStatus.description = current.description
    }
  }

  const newStatusRequest = await fetch(
    `https://api.github.com/repos/${owner}/${repo}/statuses/${sha}`,
    {
      method: 'POST',
      headers: {
        'Accept': 'application/vnd.github.v3+json',
        'Authorization': `token ${GITHUB_TOKEN}`
      },
      body: JSON.stringify({
        state: newStatus.state,
        context: newStatus.context,
        target_url: newStatus.target_url,
        description: newStatus.description || '',
      })
    }
  )

  const newStatusBody = await newStatusRequest.text()

  try {
    const newStatusJSON = JSON.parse(newStatusBody)
    return JSON.stringify(newStatusJSON, null, 2)
  } catch (err) {
    return newStatusBody
  }
}

export type Post = {
  id: string
  url: string
  title: string
  summary: string
  image: string
  author: {
    name: string
  }
}

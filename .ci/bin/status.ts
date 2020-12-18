import { CommitState, updateCommitStatus } from './utils'
import yargs from 'yargs/yargs'

const options = yargs(process.argv.slice(2))

  .option('state', {
    alias: 's',
    type: 'string',
    describe: 'Status state',
    choices: [ CommitState.pending, CommitState.success, CommitState.failure, CommitState.error ],
    demandOption: true
  })

  .option('name', {
    alias: 'n',
    type: 'string',
    describe: 'Status name'
  })

  .option('target-url', {
    alias: 't',
    type: 'string',
    describe: 'Status target url',
    demandOption: true
  })

  .option('description', {
    alias: 'd',
    type: 'string',
    describe: 'Job description'
  })

  .argv

Promise.resolve(updateCommitStatus({
  context: options.name ? `muna/ci: ${options.name}`
    : process.env['CI_JOB_NAME'] ? `muna/ci: ${process.env['CI_JOB_NAME']}`
    : `decentralan/ci`,
  state: options.state as any,
  target_url: options['target-url'],
  description: options.description || ''
}))
  .then(console.log)
  .catch((err) => {
    console.error(err)
    process.exit(0)
  })

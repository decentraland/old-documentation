import { envTLD } from "dcl-ops-lib/domain";
import { buildStatic } from "dcl-ops-lib/buildStatic";

async function main() {

  const domain = envTLD === 'co' ? 'docs.decentraland.org' : `docs.decentraland.${envTLD}`
  const certificateArn = envTLD === 'co' ? 'arn:aws:acm:us-east-1:619079673649:certificate/64b31250-8656-4bf3-ad74-dc5def47476d' : undefined

  const page = buildStatic({
    domain,
    certificateArn,
    defaultPath: '404-error/index.html',
    path: '/',
  });

  return {
    cloudfrontDistribution: page.cloudfrontDistribution,
    bucketName: page.contentBucket,
  };
}
export = main;

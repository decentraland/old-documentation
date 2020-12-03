import { envTLD } from "dcl-ops-lib/domain";
import { buildStatic } from "dcl-ops-lib/buildStatic";

async function main() {

  const tld = envTLD === 'co' ? 'org' : envTLD

  const page = buildStatic({
    domain: `docs.decentraland.${tld}`,
    path: '/',
  });

  return {
    cloudfrontDistribution: page.cloudfrontDistribution,
    bucketName: page.contentBucket,
  };
}
export = main;

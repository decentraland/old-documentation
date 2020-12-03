import { envTLD } from "dcl-ops-lib/domain";
import { buildStatic } from "dcl-ops-lib/buildStatic";
import { env } from "process";

async function main() {
  const page = buildStatic({
    domain: `docs.decentraland.${envTLD}`,
    additionalDomains: envTLD === 'co' ? [ 'docs.decentraland.org' ] : [],
    path: '/',
  });

  return {
    cloudfrontDistribution: page.cloudfrontDistribution,
    bucketName: page.contentBucket,
  };
}
export = main;

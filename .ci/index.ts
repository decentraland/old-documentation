import { envTLD } from "dcl-ops-lib/domain";
import { buildStatic } from "dcl-ops-lib/buildStatic";

async function main() {
  const page = buildStatic({
    domain: `docs.decentraland.${envTLD}`,
    path: '/',
  });

  return {
    cloudfrontDistribution: page.cloudfrontDistribution,
    bucketName: page.contentBucket,
  };
}
export = main;

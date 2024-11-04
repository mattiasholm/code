import * as pulumi from '@pulumi/pulumi';

const config = new pulumi.Config();

export const tags: { [key: string]: string } = config.requireObject('tags');
export const prefix = `${tags.Company}-${tags.Application}`.toLowerCase()

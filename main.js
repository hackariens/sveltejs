import { create } from 'create-svelte';

await create('apps', {
  name: 'apps',
  template: 'default', // or 'skeleton' or 'skeletonlib'
  types: 'typescript', // or 'typescript' or null;
  prettier: false,
  eslint: false,
  playwright: false,
  vitest: false
});
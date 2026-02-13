# mujoco_wasm — MuJoCo JavaScript/TypeScript bindings (WASM)

Official JavaScript and TypeScript bindings for the MuJoCo physics engine,
compiled to WebAssembly.
This README is intended for the npm package and focuses on installation and
basic usage.

Install

```sh
npm install mujoco_wasm
```

Quick start (ESM / TypeScript)

```ts
import loadMujoco from 'mujoco_wasm';

const mujoco = await loadMujoco();

const model = mujoco.MjModel.fromXMLString(`
<mujoco>
  <worldbody>
    <geom type="sphere" size="0.1"/>
  </worldbody>
</mujoco>
`);

const data = new mujoco.MjData(model);
mujoco.mj_step(model, data);
```

Notes

- The package is ESM (`type: module`) and ships TypeScript types.
- Ensure your bundler or dev server serves the `.wasm` asset from
  `node_modules/mujoco_wasm/dist/` at runtime.

## Versioning

Package versions follow the official MuJoCo release versions.
For example:

| npm version | MuJoCo version |
|-------------|----------------|
| 3.5.0       | 3.5.0          |

For full engine documentation, see: https://mujoco.readthedocs.io


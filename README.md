GitHub Action: PyPI Deployment
==============================

Securely build and upload Python distributions to PyPI.

## Example

```yaml
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-python@v2
      - uses: casperdcl/deploy-pypi@v2
        with:
          password: ${{ secrets.pypi_token }}
          build: true
          # only upload if a tag is pushed (otherwise just build & check)
          skip_upload: ${{ github.event_name != 'push' || !startsWith(github.event.ref, 'refs/tags') }}
```

## Why

PyPI Deployment:

- Supports `build`ing
  + supports fully customisable build command
- Supports GPG signing
- Each stage is optional (`build`, `check`, `sign` and `upload`)
- Uses a blazing fast native GitHub composite action

The main alternative GitHub Action
[pypi-publish](https://github.com/marketplace/actions/pypi-publish)
currently does not support these features.

Other features (supported by both) include:

- Supports checking built files
- Supports skipping existing uploads

## Inputs

```yaml
inputs:
  user:
    description: PyPI username
    default: __token__
  password:
    description: PyPI password or API token
    required: true
  build:
    description: `setup.py` command to run ("true" is a shortcut for "clean sdist -d <dist_dir> bdist_wheel -d <dist_dir>")
    default: false
  check:
    description: Whether to run basic checks on the built files
    default: true
  upload:
    description: Whether to upload
    default: true
  dist_dir:
    description: Directory containing distributions
    default: dist
  url:
    description: Destination repository (package index) URL
    default: ''
  gpg_key:
    description: GPG key to import for signing
    default: ''
  skip_existing:
    description: Continue uploading files if one already exists
    default: false
```

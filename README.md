GitHub Action: PyPI Deployment
==============================

Securely build and upload Python distributions to PyPI.

## Example

```yaml
    steps:
      - uses: actions/checkout@v2
      - uses: casperdcl/deploy-pypi@v1
        if: github.event_name == 'push' && startsWith(github.event.ref, 'refs/tags')
        with:
          password: ${{ secrets.pypi_token }}
          build: true
```

## Why

PyPI Deployment:

- Supports `build`ing
- Supports GPG signing
- Supports skipping existing uploads
- Is based on a tiny Docker image

The main alternative GitHub Action
[pypi-publish](https://github.com/marketplace/actions/pypi-publish)
currently does not support these features.

## Inputs

```yaml
inputs:
  user:
    description: PyPI username
    required: false
    default: __token__
  password:
    description: PyPI password or API token
    required: true
  build:
    description: Whether to run `setup.py sdist bdist_wheel`
    required: false
    default: false
  dist_dir:
    description: Directory containing distributions
    required: false
    default: dist
  url:
    description: Destination repository (package index) URL
    required: false
  gpg_key:
    description: GPG key to import for signing
    required: false
  skip_existing:
    description: Continue uploading files if one already exists
    required: false
    default: false
```

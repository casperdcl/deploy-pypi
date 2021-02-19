GitHub Action: PyPI Deployment
==============================

[![Test](https://github.com/casperdcl/deploy-pypi/actions/workflows/test.yml/badge.svg)](https://github.com/casperdcl/deploy-pypi/actions/workflows/test.yml)

Securely build and upload Python distributions to PyPI.

## Example

```yaml
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-python@v2
      - uses: casperdcl/deploy-pypi@v2
        with:
          password: ${{ secrets.PYPI_TOKEN }}
          pip: wheel -w dist/ --no-deps .
          # only upload if a tag is pushed (otherwise just build & check)
          upload: ${{ github.event_name == 'push' && startsWith(github.event.ref, 'refs/tags') }}
```

## Why

PyPI Deployment:

- Supports `build`ing
  + supports customisable build requirements
  + supports customisable build command
  + supports [PEP517](https://www.python.org/dev/peps/pep-0517) projects lacking a `setup.py` file
- Supports GPG signing
- Each stage is optional (`build`, `check`, `sign` and `upload`)
- Uses a blazing fast native GitHub composite action
- Outputs names of files for upload (for convenience in subsequent steps)
- Has the entirety of the code in a [single file](https://github.com/casperdcl/deploy-pypi/blob/master/action.yml), making it very easy to review
  + If you are [extremely security conscious](https://github.com/casperdcl/deploy-pypi/issues/6#issuecomment-721954322) you can use a commit SHA of a version you've manually reviewed (e.g. `uses: casperdcl/deploy-pypi@`[125aa19](https://github.com/casperdcl/deploy-pypi/commit/125aa19bf9c5a273d5f45648af4b4cb42ca3ddc1))

The main alternative GitHub Action
[pypi-publish](https://github.com/marketplace/actions/pypi-publish)
currently does not offer the benefits above.

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
  requirements:
    description: Build requirements
    default: twine wheel
  build:
    description: '`setup.py` command to run ("true" is a shortcut for "clean sdist -d <dist_dir> bdist_wheel -d <dist_dir>")'
    default: false
  pip:
    description: '`pip` command to run ("true" is a shortcut for "wheel -w <dist_dir> --no-deps .")'
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
outputs:
  whl:
    description: Basename of *.whl for upload
  targz:
    description: Basename of *.tar.gz for upload
  whl_asc:
    description: Basename of *.whl.asc for upload (requires <gpg_key>)
  targz_asc:
    description: Basename of *.tar.gz.asc for upload (requires <gpg_key>)
```

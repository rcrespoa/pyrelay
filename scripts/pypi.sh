SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $SCRIPTPATH/../relay
rm -rf dist || true
source $SCRIPTPATH/../.dev_tools/env/bin/activate
$SCRIPTPATH/../.dev_tools/env/bin/python3 setup.py sdist
# # python3 -m twine upload --repository testpypi dist/*
$SCRIPTPATH/../.dev_tools/env/bin/python3 -m twine upload dist/*
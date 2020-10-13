#!/bin/sh
set -x

###############################################################################
# (0) ...
###############################################################################
pwd
mkdir -p test/integration/default/files/_mapdata
ls -alR test/integration/default
sudo docker ps -a
sudo docker cp timezone-formula_debian-10_master_py3:/tmp/salt_mapdata_dump.yaml \
               test/integration/default/files/_mapdata/debian-10.yaml
git status


###############################################################################
# (A) Update `FORMULA` with `${nextRelease.version}`
###############################################################################
sed -i -e "s_^\(version:\).*_\1 ${1}_" FORMULA


###############################################################################
# (B) Use `m2r` to convert automatically produced `.md` docs to `.rst`
###############################################################################

# Install `m2r`
sudo -H pip install m2r

# Copy and then convert the `.md` docs
cp ./*.md docs/
cd docs/ || exit
m2r --overwrite ./*.md

# Change excess `H1` headings to `H2` in converted `CHANGELOG.rst`
sed -i -e '/^=.*$/s/=/-/g' CHANGELOG.rst
sed -i -e '1,4s/-/=/g' CHANGELOG.rst

# Use for debugging output, when required
# cat AUTHORS.rst
# cat CHANGELOG.rst

# Return back to the main directory
cd ..

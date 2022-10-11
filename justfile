ACT_VERSION := "0.2.32"

bin_dir := "./.bin"
act_bin := bin_dir + "/act"

_run-in-ct-docker CMD:
    docker run \
        --network host \
        --workdir=/data \
        --volume $(pwd):/data \
        quay.io/helmpack/chart-testing:v3.7.1 \
        bash -c 'git config --global --add safe.directory /data && {{ CMD }}'

_install_act:
    #!/usr/bin/env bash
    act_pkg="/tmp/act.{{ ACT_VERSION }}.tgz"
    act_url="https://github.com/nektos/act/releases/download/v{{ ACT_VERSION }}/act_Linux_x86_64.tar.gz"

    mkdir -p {{ bin_dir }}

    if [ ! -f "{{ act_bin }}" ]; then
        if [ ! -f "${act_pkg}" ]; then
            wget $act_url -O $act_pkg
        fi

        tar xf $act_pkg --directory "{{ bin_dir }}"
    fi

generate-docs:
    helm-docs

github-lint: _install_act
    "{{ act_bin }}" --job lint

github-test: _install_act
    "{{ act_bin }}" --job test

default: lint-all test-all

lint CHART: (_run-in-ct-docker "ct lint --charts "+CHART)

lint-all: (_run-in-ct-docker "ct lint --all")

lint-changed: (_run-in-ct-docker "ct lint")

test CHART:
    docker run -ti --rm -v $(pwd):/apps quintush/helm-unittest:3.10.0-0.2.9 --helm3 {{ CHART }}

test-all:
    #!/usr/bin/env bash
    for f in *; do
        if [ ! -d "$f" ]; then
            continue
        fi

        just test $f
    done

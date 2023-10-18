#!/usr/bin/env bash

CDIR="$(cd "$(dirname "$0")" && pwd)"
build_dir=$CDIR/build

while getopts A:K:q option
do
  case "${option}"
  in
    q) QUIET=1;;
    A) ARCH=${OPTARG};;
    K) KERNEL=${OPTARG};;
  esac
done

rm -rf $build_dir
mkdir -p $build_dir

cp $CDIR/pluginrc.zsh $build_dir/pluginrc.zsh
cp ~/.p10k.zsh $build_dir/p10k.zsh
# cp ~/.fzf.zsh $build_dir/fzf.zsh

cd $build_dir

[ $QUIET ] && arg_q='-q' || arg_q=''
[ $QUIET ] && arg_s='-s' || arg_s=''
[ $QUIET ] && arg_progress='' || arg_progress='--show-progress'

fzf_url='https://github.com/junegunn/fzf/releases/download/0.43.0/fzf-0.43.0-linux_amd64.tar.gz'
fzf_tarname=`basename $fzf_url`
if [ -x "$(command -v wget)" ]; then
  wget $arg_q $arg_progress $fzf_url -O $fzf_tarname
elif [ -x "$(command -v curl)" ]; then
  curl $arg_s -L $fzf_url -o $fzf_tarname
else
  echo Install wget or curl
fi
tar -xzf $fzf_tarname
mkdir bin
mv fzf bin/
rm $fzf_tarname

ohmyzsh_home=$build_dir/ohmyzsh
if [ -x "$(command -v git)" ]; then
  target_uname="linux x86_64"
  # Install FZF
  git clone $arg_q --depth 1 https://github.com/junegunn/fzf.git $build_dir/fzf

  # Install P10K
  git clone $arg_q --depth 1 https://github.com/romkatv/powerlevel10k.git $build_dir/powerlevel10k
  GITSTATUS_CACHE_DIR=$build_dir/powerlevel10k/gitstatus/usrbin $build_dir/powerlevel10k/gitstatus/install -f -s "${target_uname% *}" -m "${target_uname#* }"

  # Install Oh-my-zsh and plugins
  git clone $arg_q --depth 1 https://github.com/robbyrussell/oh-my-zsh.git ${ohmyzsh_home}
  git clone $arg_q --depth 1 https://github.com/romkatv/powerlevel10k.git ${ohmyzsh_home}/themes/powerlevel10k
  git clone $arg_q --depth 1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ohmyzsh_home}/plugins/fast-syntax-highlighting
  git clone $arg_q --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ohmyzsh_home}/plugins/zsh-autosuggestions
  git clone $arg_q --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git ${ohmyzsh_home}/plugins/fzf-zsh-plugin
else
  echo Install git
  exit 1
fi
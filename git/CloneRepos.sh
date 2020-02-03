urls=(
    "https://github.com/mattiasholm/mattiasholm.git"
    "https://github.com/hi3g-access/tre-se-deployment.git"
    "https://github.com/hi3g-access/tre-se-infra.git"
)

path=~/repos



mkdir -p $path && cd $path

for url in ${urls[@]}
do

name=$(basename $url | sed "s/.git$//")

if [[ ! -d "$path/$name" ]]
then
echo "Want to clone $url? (y/n)"
read confirm

if [ $confirm == "y" ]
then
    echo -e "Cloning $name\n"
    git clone $url
fi
else
echo -e "Git repo $name already exists, skipping\n"
fi
done
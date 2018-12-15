echo -n "Is this a good question (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo Yes
else
    echo No
fi

echo -n "Is this a good question (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo Yes
else
    echo No
fi

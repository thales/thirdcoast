# Third Coast Festival

Ruby on Rails application for ThirdCoastFestival

## Installation notes

To install JRE (for jammit):

```
sudo apt-get install openjdk-6-jre
```

Gems should be installed manually:

```
sudo gem install riddle
sudo gem install aws-s3
sudo gem install whenever
```

Make sure you're running rack 1.0.x

### Ubuntu

If there any problem with MySQL gem, try installing it with flags:

```
sudo env ARCHFLAGS="-arch x86_64" gem install mysql
```
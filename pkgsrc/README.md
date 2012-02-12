Description
===========

This cookbook provides the infrastructure necessary to use NetBSD's pkgsrc package management system in an environment managed by Chef.  It provides a package provider for the `pkgin` binary package manager.  Additionally, it provides recipes to bootstrap a machine to use pkgin, for packages which do not provide this by default.

For more information on pkgin see http://pkgin.net/

For more information on pkgsrc see http://www.netbsd.org/docs/software/packages.html

Requirements
============

Platform
--------

Tested on:

* Joyent SmartOS
* CentOS 5.5

The initial version of this cookbook was specifically developed for Joyent SmartOS & Smart machines.  Support for Linux was added by Atalanta Systems.  The provider should work for any platform which has a functioning `pkgin` binary on the $PATH.

Cookbooks
---------

No dependencies on other cookbooks.

Resources and Providers
=======================

Provides a package provider called pkgsrc which will install & remove pkgsrc packages via pkgin.  At present this only presents an install and remove action.  Upgrade and purge are aliased to install and remove respectively.

Attributes
==========

At present the second phase of the boostrap is somewhat primitive, in that it downloads the dependencies required to run `pkgin`, installs them, and then installs `pkgin`.  Because at this stage in the bootstrap we don't have an intelligent enough binary package manager, we need to specify the versions exactly.  As these will vary depending on the release of pkgsrc and patch level of the individual repository, we provide the capability to specify these as attributes.

* `node['pkgsrc']['package_server']` - HTTP or FTP path for remote server where pkgsrc binaries reside.
* `node['pkgsrc']['bootstrap_tarball']['url']` - URL of the pkgsrc bootstrap tarball.
* `node['pkgsrc']['bootstrap_tarball']['checksum']` - MD5 checksum of the bootstrap tarball.
* `node['pkgsrc']['pkgin']['dependencies']` - Hash of pkgin dependencies and version numbers
* `node['pkgsrc']['pkgin']['version']` - Version of pkgin to install

The Atalanta Systems Linux pkgsrc repository is freely available, and is specified as a sane default.  The pkgsrc bootstrap tarball is also available from the same repo, and its URL and checksum are included as sane defaults.


Recipes
=======

default
-------

As pkgsrc is an inherently multi-platform tool, it doesn't make sense to provide a default recipe.  Consequently the default recipe is just a stub.

linux-client
------------

Bootstraps a Linux (CentOS 5) machine to use `pkgin`, and configures a repository using the value in `node['pkgsrc']['package_server']`

Usage
=====

To make use of the provider, add the `pkgsrc` recipe near the top of your run list.  Alternatively apply on a per cookbook basis, thus:

    include_recipe 'pkgsrc'

This cookbook will set the default package provider for `solaris2` to be `Chef::Provider::Package::PkgSrc`.

If you wish to use this for Linux, you must explictly specify the provider in your package resources.  

Changes/Roadmap
===============

## Future

* Provide pkgsrc build server recipe
* Expand provider to support upgrade

## 0.0.2

* Documentation augmented significantly, and format changed to markdown
* Linux client recipe added

## 0.0.1

* Initial release

License and Author
==================

Author:: Benjamin W. Smith <benjaminwarfield@just-another.net> 
Author:: Stephen Nelson-Smith <stephen@atalanta-systems.com>

Copyright:: 2011, Benjamin W. Smith 
Copyright:: 2012, Atalanta Systems Ltd

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

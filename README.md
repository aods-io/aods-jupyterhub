# aods-jupyterhub

The AODS JupyterHub project is comprised primarily of a customized JupyterHub application that supports the ScalaTion big data framework in Jupyter notebooks via the ScalaTion Kernel project.
This project currently does not modify the JupyterHub code base.
Instead, it comprises a set of detailed instructions on how to configure a JupyterHub installation so that it adheres to the [AODS Guidelines](http://aods.io/#aods-guidelines).
If any changes to the JupyterHub code base are needed, then every effort will be made to properly send these changes back upstream to the main JupyterHub project.

A proof of concept installation is hosted at [`aods.io`](http://aods.io/), primarily targeted at readers of Michael E. Cotterell's Ph.D. dissertation.
The project itself includes detailed instructions on how to replicate the proof of concept setup in variety of ways, including as a containerized application (e.g., using Docker) [coming soon!].
The two primary goals of this project are i) to make replicating the basic setup as easy and painless as possible; and ii) to not let modifications prevent the inclusion of existing contributions to the Jupyter and JupyterHub projects.
This documentation project is free and open source under a Creative Commons license.

## What is AODS JupyterHub?

In a nutshell, AODS JupyterHub is a set of configuration settings and installation guides for setting up and deploying a [JupyterHub](https://jupyterhub.readthedocs.io/en/latest/) installation with [ScalaTion](http://cobweb.cs.uga.edu/~jam/scalation.html) notebook support provided by the [ScalaTion Kernel project](https://github.com/scalation/scalation_kernel) project. 
It is not officially affiliated with the main JupyterHub project. 

## Installing JupyterHub

Users should consult the [installation guide](https://jupyterhub.readthedocs.io/en/latest/installation-guide.html) provided by the main JupyterHub project.
If users only requires or need a local or containerized [Jupyter](http://jupyter.org) installation with [ScalaTion](http://cobweb.cs.uga.edu/~jam/scalation.html) notebook support, then they are encouraged to read to documentation provided by the [ScalaTion Kernel project](https://github.com/scalation/scalation_kernel).

## Social Authentication

The AODS JupyterHub installation uses GitHub accounts to authenticate users using the [`oauthenticator`](https://github.com/jupyterhub/oauthenticator) package.
Install this package following the instructions found [here](https://github.com/jupyterhub/oauthenticator).
Next, setup an OATH App on GitHub following the instructions found [here](https://developer.github.com/apps/building-integrations/setting-up-and-registering-oauth-apps/registering-oauth-apps/).
This will give you the information you need to fill out client information below.
Now, add the following settings to your `jupyter_config.py` file:

```python
from oauthenticator.github import LocalGitHubOAuthenticator
c.JupyterHub.authenticator_class = LocalGitHubOAuthenticator
c.LocalGitHubOAuthenticator.oauth_callback_url = 'http://url/to/hub/oauth_callback'
c.LocalGitHubOAuthenticator.client_id = ''
c.LocalGitHubOAuthenticator.client_secret = ''
c.LocalGitHubOAuthenticator.create_system_users = True
```

## Providing Default Notebooks

The AODS JupyterHub installation provides copies of the latest example notebooks from the [ScalaTion Kernel project](https://github.com/scalation/scalation_kernel).
These notebooks are supplied during the user creation proccess via the [`add_user.sh`](add_user.sh) script, which is called the first time a user authenticates with the JupyterHub installation.
First, download the [`add_user.sh`](add_user.sh) script to a safe location on the system (we recommend placing it next to your `jupyterhub_config.py` file).
Then, add the following settings to your `jupyter_config.py` file:

```python
c.LocalAuthenticator.add_user_cmd = ['/path/to/add_user.sh']
```

## Adding the ScalaTion Kernel

Users should consult the [installation instructions](https://github.com/scalation/scalation_kernel#general-installation-instructions) provided by the [ScalaTion Kernel project](https://github.com/scalation/scalation_kernel).

## Deployment with Nginx

A properly installed JupyterHub application does not need any additional dependencies to be deployed locally.
Below is an example that starts the application locally on either the default port (port 8000) or the port specified in `jupyterhub_config.py`.
Please ensure the environment variables point to the JAR files for a [ScalaTion](http://cobweb.cs.uga.edu/~jam/scalation.html) 1.3 (or higher) distribution if you have installed [ScalaTion Kernel](https://github.com/scalation/scalation_kernel).

```
$ export SCALATION_MATHSTAT_JAR="/path/to/scalation_mathstat.jar"
$ export SCALATION_MODELING_JAR="/path/to/scalation_modeling.jar"
$ /path/to/jupyterhub -f /path/to/jupyterhub_config.py
```

If you are using the Nginx webserver, then you can use an Nginx configuration similar to the following to proxy port 80 for a particular hostname (replace `hostname.tld`) so that it forwards to the JupyterHub application that is running locally on port 8000 (change if another port is used):

```
server {
	listen 80;
	server_name hostname.tld;

	location / {
		proxy_set_header Host $host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_pass http://127.0.0.1:8000;
	}

	location ~ /api/kernels/ {
	        proxy_pass            http://127.0.0.1:8000;
        	proxy_set_header      Host $host;
		      proxy_set_header X-Real-IP $remote_addr;
		      proxy_http_version    1.1;
		      proxy_set_header      Upgrade "websocket";
        	proxy_set_header      Connection "Upgrade";
        	proxy_read_timeout    86400;
    }

}
```

Instructions for Apache2 are coming soon!

<hr>
<small>
<p><a href="https://creativecommons.org/licenses/by-sa/4.0/"><img src="https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg" alt="License: CC BY-SA 4.0" /></a></p>
<p>Copyright 2017 Michael E. Cotterell (mepcott@uga.edu) and the University of Georgia. The documentation fot this work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>. The software projects described here may be subject to their own licenses. The content and opinions expressed on this Web page do not necessarily reflect the views of nor are they endorsed by the University of Georgia or the University System of Georgia.</p>
</small>

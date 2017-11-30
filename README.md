# aods-jupyterhub

The AODS JupyterHub project is comprised primarily of a customized JupyterHub application that supports the ScalaTion big data framework in Jupyter notebooks via the ScalaTion Kernel project.
This project currently does not modify the JupyterHub code base.
Instead, it comprises a set of detailed instructions on how to configure a JupyterHub installation so that it adheres to the [AODS Guidelines](http://aods.io/#aods-guidelines).
If any changes to the JupyterHub code base are needed, then every effort will be made to properly send these changes back upstream to the main JupyterHub project.

A proof of concept installation is hosted at [`aods.io`](http://aods.io/), primarily targeted at readers of Michael E. Cotterell's Ph.D. dissertation.
The project itself includes detailed instructions on how to replicate the proof of concept setup in variety of ways, including as a containerized application (e.g., using Docker) [coming soon!].
The two primary goals of this project are i) to make replicating the basic setup as easy and painless as possible; and ii) to not let modifications prevent the inclusion of existing contributions to the Jupyter and JupyterHub projects.
This documentation project is free and open source under a Creative Commons license.

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

<hr>
<small>
<p><a href="https://creativecommons.org/licenses/by-sa/4.0/"><img src="https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg" alt="License: CC BY-SA 4.0" /></a></p>
<p>Copyright 2017 Michael E. Cotterell (mepcott@uga.edu) and the University of Georgia. The documentation fot this work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>. The software projects described here may be subject to their own licenses. The content and opinions expressed on this Web page do not necessarily reflect the views of nor are they endorsed by the University of Georgia or the University System of Georgia.</p>
</small>

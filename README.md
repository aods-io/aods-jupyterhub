# aods-jupyterhub

The AODS JupyterHub project is comprised primarily of a customized JupyterHub application that supports the ScalaTion big data framework in Jupyter notebooks via the ScalaTion Kernel project.
This project currently does not modify the JupyterHub code base.
Instead, it comprises a set of detailed instructions on how to configure a JupyterHub installation so that it adheres to the [AODS Guidelines](http://aods.io/#aods-guidelines).
If any changes to the JupyterHub code base are needed, then every effort will be made to properly send these changes back upstream to the main JupyterHub project.

A proof of concept installation is hosted at [`aods.io`](http://aods.io/), primarily targeted at readers of Michael E. Cotterell's Ph.D. dissertation.
The project itself includes detailed instructions on how to replicate the proof of concept setup in variety of ways, including as a containerized application (e.g., using Docker) [coming soon!].
The two primary goals of this project are i) to make replicating the basic setup as easy and painless as possible; and ii) to not let modifications prevent the inclusion of existing contributions to the Jupyter and JupyterHub projects.
This documentation project is free and open source under a Creative Commons license.

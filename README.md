# openb3d.mod
Working branch of markcw's BlitzMax wrapper for Openb3d library

Openb3d.mod
===========

BlitzMax wrapper for Openb3d library version 1.1, an OpenGL 2.0-capable 3d engine based on Minib3d which is itself based on Blitz3D. As a result the documentation mainly uses the online Blitz3d manual and help can be found at the www.blitzmax.com boards.

The wrapper is object-oriented and also has a procedural interface like Blitz3D, so syntax is not identical but the types are documented and are the same as in Minib3d. The Max2D module is used for 2d-in-3d rendering which replaces the core of the 2d language set in Blitz3d, other modules such as Brl.Math cover the rest. The coordinate system is flipped from the OpenGL orientation to be like Blitz3d so porting code will be easier. Image loading is done by the STB image library instead of Brl image loaders so Pixmaps are not used in textures. Also, Quaternions are used instead of Eulers which prevents gimbal lock.

Several examples are included for testing and extra features include: particles, stencil testing, terrains, stencil shadows, md2 animation, shaders with post processing effects.

Status
======

Possibly occasionally updated, on rare occasions.

The main reason for uploading this repository is to store a working copy of [markcwm's OpenB3D wrapper for BlitzMax](https://github.com/markcwm/openb3d.mod/ "OpenB3D Wrapper"). The project was discontinued with a non-working version left behind, so this fork was taken from [mostly-working branch f152c0280812508814e7bf81f336eacf7d9b65cd](https://github.com/markcwm/openb3d.mod/commit/f152c0280812508814e7bf81f336eacf7d9b65cd/ "Mostly-working branch") and a few fixes/tweaks applied.

Changes so far:

* Fixed `HearingPoint = New HearingPoint` in openb3d.mod\b3dsound.mod\b3dsound.bmx; should have been `HearingPoint = New ListeningPoint`;
* Fixed EntityName/EntityClass, which in turn fix GetChild/FindChild;
* Added `Entity::MQ_ApplyNewtonTransform()` for updating mesh matrices using Newton Dynamics body matrices;
* Added experimental bmx-ng-specific operator overloading for adding/subtracting meshes using CSG features, via `mesh3 = mesh1 + mesh2`, `mesh3 = mesh1 - mesh2` and the like;
* Added Doxygen-generated class documentation (in html folder -- click \_Start shortcut or index.html if that doesn't work!)

License
=======

OpenB3D is licensed under the *GNU LGPLv2 or later*, _with an exception to allow static linking_.

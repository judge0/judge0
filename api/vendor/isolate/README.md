isolate
=======

Isolate is a sandbox built to safely run untrusted executables,
offering them a limited-access environment and preventing them from
affecting the host system. It takes advantage of features specific to
the Linux kernel, like namespaces and control groups.

Isolate was developed by Martin Mareš (<mj@ucw.cz>) and Bernard Blackham
(<bernard@blackham.com.au>), who still maintain it. Several other people
contributed patches for features and bug fixes (see Git history for a list).
Thanks!

Originally, Isolate was a part of the [Moe Contest Environment](http://www.ucw.cz/moe/),
but it evolved to a separate project used by different
contest systems, most prominently [CMS](https://github.com/cms-dev/cms).
It now lives at [GitHub](https://github.com/ioi/isolate),
where you can submit bug reports and feature requests.

If you are interested in more details, please read Martin's
and Bernard's [paper](http://mj.ucw.cz/papers/isolate.pdf) presented
at the IOI Conference. Also, Isolate's [manual page](http://www.ucw.cz/moe/isolate.1.html)
is available online.

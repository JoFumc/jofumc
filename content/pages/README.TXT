The "content/pages" directory contains a set of directories,
each of which contains a template and zero or more page 
fragments.  During build time, the template is applied to
each fragment to generate a PHP "page" to be staged in 
the root content directory.

This is different from the "content/blocks" directory, which
contains fragments that will be incorporated dynamically at
runtime (either by PHP include/require or by AJAX methods).


<!-- README.md is generated from README.Rmd. Please edit that file -->

# Package template

This repository is a template for creating a new R package in DSM. It
includes a basic package structure and a GitHub workflows for R CMD
check and pkgdown in various formats.

## Get started

To create a new package from this template, click the green “Use this
template” button at the top of the repository.

1.  Name your repository with camelCase, e.g. `myNewPackage`. This is
    the CRAN standard for package names.
2.  Git clone your new repository to your local machine.
3.  Open the myNewPackage.Rproj file in RStudio, do a global search,
    replace `test-dsm-pkg`to replace with your package name, replace
    `template-package` with your package name.
4.  Open the DESCRIPTION file and replace the fields with your package
    information, such as Title, Description, Author, Maintainer,
    License, etc.
5.  Run `renv::restore()` to install the package dependencies. Later,
    when you install new packages, use `renv::snapshot()` to update.
6.  Start to add new functions and documentation to your package. They
    should be stored in the `R/` folder. The documentation should be
    formatted using roxygen2. Use `devtools::document()` to update the
    documentation.
7.  For package imports and dependencies, first add them to
    `R/<name of your pkg>-package.R` using `roxygen2` syntax. Then run
    `devtools::document()` to update the NAMESPACE file. Then if this is
    a new dependency, add it to the DESCRIPTION as well.
8.  Add tests to the `tests/testthat` folder. Use `devtools::test()` to
    run the tests.
9.  The `README.md` file should not be edited directly. Instead, edit
    the `README.Rmd` file and knit it to update the `README.md`.

## Guide for functions

1.  In DSM, functions are named using snake_case, e.g. `my_function`.

2.  The line length should be less than 80 characters. This can be set
    in RStudio by going to Tools -\> Global Options -\> Code -\> Display
    and setting the “Margin Column” to 80.

3.  The function should have a roxygen2 documentation block even if it
    is a private function. The documentation should include a title,
    description, parameters, return value, and examples.

    ``` r
    #' My function
    #' @description This function takes a number and returns its square.
    #' @param x numeric, length 1. The number to be squared.
    #'
    #' @return numeric, length 1. The square of x.
    #' @export
    #'
    #' @examples
    #' my_function(3)
    my_function <- function(x) {
      ...
    }
    ```

    - The first line should be a short and meaningful title.
    - Use `@description` to describe what the function does starting
      from the second line.
    - `@param` is used to describe the parameters of the function. The
      format is `@param <name> <type>, <length> <description>`. For
      example, `@param x numeric, length 1. The number to be squared.`
      or `@param x character, vector. The name of the person.`
    - `@return` is used to describe the return value of the function.
      For example, `@return numeric, length 1. The squared value of x.`
      or `@return NULL. The function does not return anything.`
    - `@export` is used only on functions that are meant to be used by
      the user. Private functions should not have this tag.
    - `@examples` is used to provide examples of how to use the
      function. All public functions should have examples. Private
      functions should have examples if they are complex or important.

## GitHub workflows

This template includes many GitHub workflows to automate. By default,
they are all turned off by placing them in the `.github/template`
folder. To enable them, move them to the `.github/workflows` folder.

### R CMD check

1.  `R_CMD_check_public.yaml` runs the full R CMD check on the package
    on all three major operating systems. However, if this repository is
    private, running this workflow will charge DSM credits.
    - By default, this workflow is trigger by all changes by push.
    - There is an alternative which only monitor the changes in core
      files (e.g. R/ ). Please read the comments in the file for more
      information.
    - This workflow is usually used for packages that are ready to be
      submitted to CRAN.
2.  `R_CMD_check_internal.yaml` runs the full R CMD check only on
    Unbuntu 22.04. This workflow is free and uses DSM runners. If you
    want to keep the repository private, this is the better option. Thi
    is the **default**.
    - There is a downside of this workflow. Due to the limitation of DSM
      runners, the CMD check will always produce a warning during the
      check. This causes the workflow to fail. Therefore, the workflow
      is set to fail only on `error`. If you see the workflow passed,
      make sure to check the logs to see if there are any warnings.

### pkgdown

Rendering a pkgdown website is very time-consuming and the community
standard is to render it locally and save it in the `docs/` folder. This
folder is then pushed to the repository and GitHub Pages picks it up
without any additional rendering.

1.  If this is the case for your package. Go to repository settings and
    enable GitHub Pages for the `main` branch and the `docs/` folder. In
    this way, there is no need to run any workflows.
2.  `ghpage_copy_only.yaml` is the workflow that copies the `docs/`
    folder to the `gh-pages` branch if you prefer to use another branch
    for the website.
3.  `ghpage_pkgdown.yaml` is the workflow that renders the the docs
    folder using pkgdown and pushes it to the `gh-pages` branch.
    Therefore, you don’t need to pre-render the website locally. Watch
    how long it takes to render the website. If it takes too long,
    consider using the first 2 options.

In DSM, pkgdown sites by **default** are rendered and uploaded to Crane
sites. This first requires one to set up the Crane permissions. This is
done by using the `permissions.yml` file. Pay attention to the access
permission part of the file. By default, the site is only accessible to
the DSM developers (`dsm_dev`). You can specify the access permission to
other groups or individuals (use `access-users` entry with their
keycloak emails). This permission file will be picked up by the
`crane_permission.yaml` workflow and there is nothing you need to change
in the workflow file.

Move downwards, there are two options to deploy to Crane, render the
pkgdown site and upload it to Crane, or only upload the pre-rendered
site to Crane.

1.  `crane_pkgdown_upload.yaml` is the workflow that only uploads it to
    Crane. This is the **default**.
2.  `crane_pkgdown_render_upload.yaml` is the workflow that renders the
    pkgdown site and uploads it to Crane.

If you have done the global search and replace correctly, there is no
need to change anything in the workflow files.

Besides, in these two workflows, there is a `project_on_s3`. The default
is `abcd` and the other option is `hbcd`. Make sure this value
**matches** what you have in the `permissions.yml` `project` field.

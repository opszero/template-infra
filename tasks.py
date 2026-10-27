from invoke import task


@task
def fmt(c):
    """Run terraform fmt recursively."""
    c.run("terraform fmt -recursive")


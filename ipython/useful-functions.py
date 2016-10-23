# Useful python helper functions

def read_lines_in_file(filename):
    """
    Return a list of lines in filename
    """

    return map(lambda x: x.strip(), open(filename).readlines())


def read_contents_of_file(filename):
    """
    Read contents of a file as a single string
    """

    return open(filename).read()

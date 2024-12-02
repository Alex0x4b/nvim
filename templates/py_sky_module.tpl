;; python
# import pandas as pd
# import akutils as ak
from nsp import utils_nsp


def main_{{_file_name_}}(data_dir, local_storage):
    path_to_data = utils_nsp.get_path_to_data(data_dir, local_storage)
    return path_to_data


if __name__ == "__main__":
    """
    # all
    from nsp.analyses.{{_file_name_}} import *
    data_dir = "data"

    # gdp
    local_storage = False
    read_csv_kwargs = {"nrows": None}

    # local
    local_storage = True
    read_csv_kwargs = {"nrows": 50000}
    """

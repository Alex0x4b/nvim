;; python
# import pandas as pd
# import akutils as ak
from nsp import utils_nsp


def main_{{_file_name_}}(data_dir, local_storage):
    path_to_data = utils_nsp.get_path_to_data(data_dir, local_storage)
    {{_cursor_}}
    return path_to_data


if __name__ == "__main__":
    """
    # all
    from nsp.analyse.{{_file_name_}} import *
    from datetime import datetime
    extract_kwargs = {
        "date_ref": datetime(2024, 10, 31),
        "prf_month_contract": 27,
    }

    # gdp
    data_dir="data"
    local_storage = False
    read_csv_kwargs = {"nrows": None}


    # local
    data_dir = "data_history"
    local_storage = True
    read_csv_kwargs = {"nrows": 50000}
    """

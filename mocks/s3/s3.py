# Copyright 2023 Red Hat, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Mock web server that returns a fake archive."""


from fastapi import FastAPI
from fastapi.responses import FileResponse

without_workloadinfo_path = "test_data/archive_no_workloadinfo.tar.gz"
with_workloadinfo_path = "test_data/archive.tar.gz"
app = FastAPI()


@app.get("/archive_no_workloadinfo")
def archive_without_workloadinfo():
    """Return a mocked archive for every request.

    The archive returned does NOT contain workload_info.json file
    """
    return FileResponse(path=without_workloadinfo_path)


@app.get("/archive")
def archive_with_workloadinfo():
    """Return a mocked archive for every request.

    The archive contains workload_info.json file
    """
    return FileResponse(path=with_workloadinfo_path)

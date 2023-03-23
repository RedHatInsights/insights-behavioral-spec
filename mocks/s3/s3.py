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

file_path = "test_data/archive.tar.gz"
app = FastAPI()


@app.get("/archive")
def main():
    """Return a mocked archive for every request."""
    return FileResponse(path=file_path)

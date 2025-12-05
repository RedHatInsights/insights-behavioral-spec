# AGENTS.md

## Purpose

This repository contains behavioral specifications for Internal and External data pipelines and their integration into various Red Hat services including OCM (OpenShift Cluster Manager), OCP (OpenShift Container Platform), ACM (Advanced Cluster Management), Notification Service, and ServiceLog.

The specifications are written using Behavior-Driven Development (BDD) methodology with:
- **Gherkin language** for test scenarios (`.feature` files)
- **Python 3.x** with the Behave framework for test step implementations
- Integration tests that validate service behavior from a black-box perspective using [Behave](https://github.com/behave/behave) framework

This repository serves as the single source of truth for behavioral testing across the processing team, ensuring consistent validation of service functionality, API contracts, and integration points that are then used in the CI/CD pipelines of each repository.

## Folder Overview

```
insights-behavioral-spec/
├── config/              # Configuration files for various services (TOML, YAML, ENV)
├── docs/                # Documentation (BDD intro, feature lists, tools, etc.)
├── features/            # BDD test specifications and implementations
│   ├── ACM/             # Advanced Cluster Management (multi-cluster) tests
│   ├── ccx-notification-service/ # Notification service tests
│   ├── ccx-notification-writer/  # Notification writer tests
│   ├── ccx-upgrades-data-eng/    # Data engineering service tests
│   ├── ccx-upgrades-inference/   # Inference service tests
│   ├── DVO_Recommendations/      # DVO recommendation tests
│   ├── dvo-extractor/            # DVO extractor tests
│   ├── dvo-writer/               # DVO writer tests
│   ├── Insights_Advisor/         # Insights Advisor tests
│   ├── insights-content-service/ # Content service tests
│   ├── insights-content-template-renderer/  # Template renderer tests
│   ├── insights-results-aggregator/         # Aggregator tests
│   ├── insights-results-aggregator-cleaner/ # Cleaner tests
│   ├── insights-results-aggregator-exporter/# Exporter tests
│   ├── insights-results-aggregator-mock/    # Mock service tests
│   ├── OCM/                      # OpenShift Cluster Manager tests
│   ├── OCP_WebConsole/           # OCP Web Console tests
│   ├── parquet-factory/          # Parquet factory tests
│   ├── SHA_Extractor/            # SHA extractor tests
│   ├── smart-proxy/              # Smart proxy tests
│   ├── src/                      # Shared Python utilities
│   ├── steps/                    # Behave step implementations
│   ├── environment.py            # Behave environment setup (actions to run before and after testing)
│   └── environment_test.py       # Environment test utilities
├── logs/                # Test execution logs organized by service
├── mocks/               # Mock services for testing (content-service, prometheus, etc.)
├── setup/               # Database setup scripts (SQL files)
├── test_data/           # Test data files (JSON, compressed files)
├── test_list/           # Lists of test scenarios per service
├── tools/               # Utility scripts (scenario list generator, code style checker)
├── *_tests.sh           # Service-specific test execution scripts
├── docker-compose.yml   # Docker Compose configuration for test infrastructure
├── Makefile             # Build and test targets
├── requirements.txt     # Python dependencies
└── run_tests.sh         # Main test runner script
```

### Key Directories

- **`features/`**: Contains all BDD feature files (`.feature`) and their step implementations. Each service has its own subdirectory. You should use different files files for different features, for example if you are testing an integration with a service, dedicate one file for that specific purpose. This helps organizing the scenarios and makes it easier to understand the purpose of each test.
- **`features/steps/`**: Python implementations of Gherkin step definitions.
- **`config/`**: Service configuration files used during testing.
- **`mocks/`**: Mock implementations of external services (not part of the processing team repositories) to enable isolated testing. It is preferable to use mocks instead of adding dependencies that may need to run as containers or in the background.
- **`test_data/`**: Sample data files used in test scenarios.
- **`setup/`**: SQL scripts for database initialization and cleanup.

## Best Development Practices

As an agent, you should create a TODO list with the following sections:

### Code Style and Quality

1. **Python Code Style**
   - Run `make code-style` before committing to check Python code style
   - Use `make ruff` to run the Ruff linter
   - Follow PEP 8 conventions
   - Run `make docs-style` to check documentation strings

2. **Shell Scripts**
   - Run `make shellcheck` to validate shell scripts
   - Use `#!/bin/bash -x` for debugging when needed

3. **Type Checking**
   - Install type libraries: `make install-type-libraries`
   - Run type checks: `make type-checks`
   - For strict checking: `make strict-type-checks`

### BDD Test Development

1. **Writing Feature Files**
   - Use clear, descriptive scenario names
   - Follow Given-When-Then structure
   - Use appropriate tags (`@skip`, `@managed`, `@local`, etc.)
   - Document scenarios with clear business language

2. **Step Implementations**
   - Reuse existing step definitions when possible
   - Keep step implementations focused and testable
   - Use the `context` object to share state between steps
   - Handle cleanup in `after_scenario` hooks

3. **Test Organization**
   - Group related scenarios in feature files
   - Use tags to categorize tests (`@database`, `@rest-api`, `@s3`, etc.)
   - Update scenario lists: `make update-scenarios`

### Keeping documentation up to date

The documentation is generated from the scenario list in the `docs/scenarios_list.md` file, that is then rendered on the GitHub pages.
To keep the documentation up to date, you need to run `make update-scenarios` after adding new scenarios or modifying existing ones.

### Pre-Commit Checklist

Before committing, run:
```bash
make before_commit
```

to ensure that the code style is correct and the documentation is up to date.

## How to Run Locally

### Prerequisites

- Python 3.x
- Docker and Docker Compose

### Setup

1. **Clone the repository** (if not already done):
   ```bash
   git clone <repository-url>
   cd insights-behavioral-spec
   ```

2. **Create and activate virtual environment**:
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

### Running Tests

#### Option 1: Using Docker Compose (Recommended)

1. **Start test infrastructure**:
   ```bash
   # Start base services (database)
   docker-compose up -d
   
   # Start exporter-related services
   docker-compose --profile test-exporter up -d
   
   # Start notification services (requires specific DB name)
   POSTGRES_DB_NAME=notification docker-compose --profile test-notification-services up -d
   ```

2. **Run specific service tests**:
   ```bash
   make notification-service-tests
   make aggregator-tests
   make exporter-tests
   # ... see Makefile for all available targets
   ```

#### Option 2: Using Makefile Targets

Run tests for specific services:
```bash
make cleaner-tests
make aggregator-tests
make aggregator-mock-tests
...
```

See `make help` for all available targets

#### Option 3: Using Test Scripts Directly

Run service-specific test scripts:
```bash
./notification_service_tests.sh
./insights_results_aggregator_tests.sh
./exporter_tests.sh
# ... etc.
```

You can modify the script to filter for specific tags or scenarios, for example.

#### Option 4: Using Behave Directly

Run specific feature files or scenarios:
```bash
# Run all tests
PYTHONDONTWRITEBYTECODE=1 python3 -m behave --tags=-skip

# Run specific feature
python3 -m behave features/ccx-notification-service/smoketests.feature

# Run with specific tags
python3 -m behave --tags=@rest-api --tags=-skip
```

### Running Without Docker

If you have services running locally:

1. Ensure required services are running (PostgreSQL, Kafka, etc.)
2. Update test scripts to remove `@managed` tags or add `@local` tags
3. Set `PATH` environment variable to include service executables
4. Run tests as described above

### Additional Commands

- **Unit tests**: `make unit_tests`
- **Code coverage**: `make coverage`
- **Coverage report (HTML)**: `make coverage-report`
- **View all Makefile targets**: `make help`

## How to Create New PRs

### Before Creating a PR

1. **Ensure all checks pass**:
   ```bash
   make before_commit
   ```

2. **Update scenario lists** (if adding new scenarios):
   ```bash
   make update-scenarios
   ```

3. **Test your changes locally**:
   - Run the specific test suite you modified
   - Verify tests pass both locally and in Docker (if applicable)
   - Check that new tests are included in scenario lists

### PR Template Requirements

When creating a PR, use the template in `PULL_REQUEST_TEMPLATE.md`.

### PR Checklist

Before pushing the changes, ensure:

- [ ] The make before_commit checks pass
- [ ] Code follows style guidelines
- [ ] Tests are properly tagged
- [ ] Documentation is updated
- [ ] Scenario lists are updated
- [ ] No merge conflicts with main branch


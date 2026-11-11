# Apna Circle

A prototype for discovering and hosting neighborhood social activities, with cultural community filters, map-based discovery, and calendar links.

## Run locally

Open `index.html` in a modern browser with an internet connection. For local `events.json` loading, serve this folder over HTTP:

```sh
python3 -m http.server 8000
```

Then visit http://localhost:8000.

## Current limitations

**Demo only — not ready for public launch.** Activity and join-request state is browser-local. Sample activities are illustrative, not verified live events. The event feed is empty by default. The map and images depend on third-party services. Google Maps and Calendar are outbound links, not OAuth integrations.

Do not enter real personal or sensitive information. No real accounts, server-side authorization, transactional approval, moderation backend, or production deployment are provided.

See [RELEASE_STATUS.md](RELEASE_STATUS.md), [QA_REVIEW.md](QA_REVIEW.md), and [AGENT_WORKFLOW.md](AGENT_WORKFLOW.md).

## Development workflow

Developer implementation → Independent tester evidence → Product Owner release gate. No public launch until critical release criteria pass.

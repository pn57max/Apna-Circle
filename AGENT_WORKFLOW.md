# Apna Circle — Developer → Tester → Product Owner workflow

## Current status
**NO-GO for public launch.** This package is a static browser-local prototype. No deployment or real multiuser backend exists.

## Developer agent (implementation)
Input: prioritized defects, acceptance criteria, latest repository/build.
Deliver: code changes, migrations, automated tests, change log, security considerations.
P0 build backlog: authentication and account recovery; server-side activity CRUD; transactional join approvals and capacity enforcement; report/block and moderation; abuse/rate limiting; secure hosting and secrets; privacy policy and terms; consent and data retention.

## Tester agent (independent verification)
Run unit, integration, and browser E2E tests against a deployed staging URL. Cover account signup/login, authorization, hosting, approval, race conditions, filters and map pins, geocoding, external feeds, calendar timezone/DST, accessibility WCAG 2.2 AA, mobile and security regression. Provide reproducible failing cases, screenshots/logs and test artifacts. Never call a static check an E2E pass.

## Product Owner agent (release gate)
Independently compare acceptance criteria to evidence. Review accessibility, community trust, age-friendly UX, data correctness, operational support and privacy. Mark GO only when P0 defects are closed, P1 risks explicitly accepted, tests are green, production monitoring/rollback exists, and policies are published.

## Iteration contract
Developer implements → Tester tests → Product Owner validates → repeat while failing gates. No production deployment without owner approval. Each cycle must report: build/version, changes, tests run/pass/fail/not run, open P0/P1/P2, next owner/actions, and release verdict.

## Prerequisites for autonomous iteration
Connect a persistent GitHub/GitLab repository and staging deployment to ChatGPT Work or another agent-capable development environment with explicit write/test permissions. A local ZIP alone does not provide persistent autonomous execution. The existing daily QA automation can review accessible builds, but it cannot guarantee continuous code changes or independent multi-agent orchestration.

## Release gates
1. Identity/authentication and server-side authorization
2. Transactional activities and join approval; verified attendance rules
3. Report/block, moderation, safety escalation, privacy policy, terms
4. Verified venues and map data; legitimate external events with cancellation handling
5. Automated unit/integration/E2E + accessibility/security review
6. Hosting, monitoring, backups, incident response and rollback
7. Product Owner acceptance on real staging evidence
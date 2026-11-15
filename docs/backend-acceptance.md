# Backend foundation release gate

Status: NO-GO. SQL committed, not applied or executed.

## Staging acceptance tests
Use separate authenticated accounts (host, member A, member B, outsider).
1. Unauthenticated activity reads and RPC calls must be denied.
2. Authenticated host creates a future activity with capacity 2.
3. Member A requests to join twice; exactly one pending record exists.
4. Host self-request fails. Outsider cannot approve requests.
5. Host approves A; approval of B fails when full.
6. Concurrent approvals on capacity 2 must result in exactly one approved member.
7. Invalid dates and capacity are rejected.
8. Other members cannot read another member's request.
9. Direct writes to join_requests are denied.

## Remaining work
Connect staging Supabase; apply migration; implement authenticated frontend; add cancellation, moderation, event validation, privacy and account deletion; execute tests; deploy staging; obtain independent review. No production deployment.

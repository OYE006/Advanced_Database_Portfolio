CREATE INDEX idx_transfers_status_created
    ON transfers(status, created_at);

CREATE INDEX idx_transfers_source_created
    ON transfers(source_account_id, created_at);

CREATE INDEX idx_transfers_destination_created
    ON transfers(destination_account_id, created_at);

CREATE INDEX idx_ledger_account_created
    ON ledger_entries(account_id, created_at);

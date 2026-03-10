-- Sessions logs: supports the date-filtered window function + status filter
CREATE INDEX IF NOT EXISTS idx_sessions_logs_created
    ON sessions.sessions_logs (created)
    INCLUDE (session_id, user_id, status, app_release_uuid);

-- WebRTC stats: supports the LATERAL lookups by session_id
CREATE INDEX IF NOT EXISTS idx_webrtc_stats_session_created
    ON stats.webrtc_stats_logs (session_id, created DESC);

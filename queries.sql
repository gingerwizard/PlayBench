SELECT * FROM checks LIMIT 12
SELECT * FROM checks WHERE check_start_time >= '2022-11-01' and test_name like '%Fatal message in clickhouse-server.log (see fatal_messages.txt)%' and test_status in ('FAIL', 'FLAKY') and report_url like '%tsan%' order by check_start_time desc
SELECT * FROM checks WHERE check_start_time >= toDateTime('2022-11-18 21:48:54') - interval 1 month and report_url like '%perf%' and test_name = 'sparse_column #27' and test_status = 'slower'
SELECT * FROM checks WHERE check_start_time >= toDateTime('2022-11-18 21:48:54') - interval 1 week and report_url like '%perf%' and test_name = 'sparse_column #27' and test_status = 'slower'
SELECT * FROM checks WHERE check_start_time >= toDateTime('2022-11-18 21:48:54') - interval 1 week and report_url like '%perf%' and test_name like '%sparse_column%'
SELECT * FROM checks WHERE check_start_time >= toDateTime('2022-11-18 21:48:54') - interval 1 week and report_url like '%perf%' and test_name like '%sparse_column%' LIMIT 10
SELECT * FROM checks WHERE check_start_time >= toDateTime('2022-11-18 21:48:54') - interval 1 week and report_url like '%perf%' and test_name like '%sparse_column%' and test_status = 'slower'
SELECT * FROM checks WHERE check_start_time >= toDateTime('2022-11-18 21:48:54') - interval 1 year and report_url like '%perf%' and test_name = 'sparse_column #27' and test_status = 'slower'
SELECT * FROM checks WHERE report_url like '%perf%' LIMIT 10
SELECT * FROM checks WHERE report_url like '%perf%' and test_name = 'sparse_column' LIMIT 10
SELECT * FROM checks WHERE report_url like '%perf%' and test_name like '%sparse_column%' LIMIT 10
SELECT * FROM checks WHERE test_name is not null and test_name<>'' LIMIT 12
SELECT *, report_url, substring(check_name, 1, 15) || '...' || substring(check_name, -15) as check, substring(test_name, -50) as test, check_start_time, test_status, substring(commit_sha, 1, 10) as commit_short, pull_request_number as prnum, multiIf( toDateTime('2022-11-18 21:48:54') - INTERVAL '1' day <= check_start_time, '<1d', toDateTime('2022-11-18 21:48:54') - INTERVAL '7' day <= check_start_time, '<1w', '') as last FROM checks WHERE test_status not in ('OK', 'SKIPPED') AND test_name like '%01072_window_view_multiple_columns_groupby%' AND toDateTime('2022-11-18 21:48:54') - INTERVAL '30' day <= check_start_time ORDER BY check_start_time DESC LIMIT 100
SELECT *, substring(check_name, 1, 15) || '...' || substring(check_name, -15) as check, substring(test_name, -50) as test, check_start_time, test_status, substring(commit_sha, 1, 10) as commit_short, pull_request_number as prnum, multiIf( toDateTime('2022-11-18 21:48:54') - INTERVAL '1' day <= check_start_time, '<1d', toDateTime('2022-11-18 21:48:54') - INTERVAL '7' day <= check_start_time, '<1w', '') as last FROM checks WHERE test_status not in ('OK', 'SKIPPED') AND test_name like '%02275_full_sort_join_long%' AND toDateTime('2022-11-18 21:48:54') - INTERVAL '10' day <= check_start_time ORDER BY check_start_time DESC LIMIT 20
SELECT DISTINCT test_name FROM checks WHERE test_name like '%test_query_is_lock_free%' AND toDateTime('2022-11-18 21:48:54') - INTERVAL '10' day <= check_start_time ORDER BY check_start_time DESC LIMIT 20
SELECT a.check_name,a.check_status,a.rn FROM (SELECT check_name,check_status,row_number() over(partition by test_status order by check_start_time desc) rn FROM checks)a WHERE a.rn=1 LIMIT 12
SELECT aa.test_name,aa.check_status,check_start_time,row_number() over(partition by test_name order by check_start_time) rn FROM (SELECT * FROM checks WHERE test_name is not null and test_name<>'' LIMIT 200000000) aa LIMIT 23
SELECT aa.test_name,aa.check_status,row_number() over(partition by test_name order by check_start_time) rn FROM (SELECT * FROM checks WHERE test_name is not null and test_name<>'' LIMIT 200000000) aa LIMIT 12
SELECT aa.test_name,aa.check_status,row_number() over(partition by test_name order by check_start_time) rn FROM (SELECT * FROM checks WHERE test_name is not null and test_name<>'' LIMIT 200000000) aa LIMIT 333
SELECT aa.test_name,aa.check_status,row_number() over(partition by test_name) rn FROM (SELECT * FROM checks WHERE test_name is not null and test_name<>'' LIMIT 200000000) aa LIMIT 12
SELECT any(check_start_time) as time, any(pull_request_number) as pr, extract(check_name, '(.*)') as mode, count() FROM checks WHERE check_name ilike '%integration%' and check_start_time >= toDate('2022-11-18') - interval 14 day GROUP by mode, commit_sha order by time desc
SELECT any(check_start_time) as time, any(pull_request_number) as pr, extract(check_name, '(.*)') as mode, count() FROM checks WHERE check_name ilike '%integration%' and check_start_time >= toDate('2022-11-18') - interval 14 day and pull_request_number = 0 GROUP by mode, commit_sha order by time desc
SELECT any(check_start_time) as time, arraySort(groupUniqArray(check_name)) as checks, extract(check_name, '(.*)') as mode, count() FROM checks WHERE check_name ilike '%integration%' and check_start_time >= toDate('2022-11-18') - interval 14 day and pull_request_number = 0 GROUP by mode, commit_sha order by time desc
SELECT any(check_start_time) as time, arraySort(groupUniqArray(check_name)) as checks, extract(check_name, '(.*)') as mode, count() FROM checks WHERE check_name ilike '%integration%' and check_start_time >= toDate('2022-11-18') - interval 14 day and pull_request_number = 0 and mode = '(release)' GROUP by mode, commit_sha having length(checks) = 2 order by time desc
SELECT any(check_start_time) as time, groupArray(check_name) as checks, extract(check_name, '(.*)') as mode, count() FROM checks WHERE check_name ilike '%integration%' and check_start_time >= toDate('2022-11-18') - interval 14 day and pull_request_number = 0 GROUP by mode, commit_sha order by time desc
SELECT base_ref,count(1) FROM checks GROUP by base_ref
SELECT bb.* FROM ( SELECT aa.test_name,aa.check_status,row_number() over(partition by test_name order by check_start_time) rn FROM (SELECT * FROM checks WHERE test_name is not null and test_name<>'' LIMIT 200000000) aa ) bb WHERE bb.rn = 1 LIMIT 12
SELECT bb.* FROM ( SELECT aa.test_name,aa.check_status,row_number() over(partition by test_name order by check_start_time) rn FROM (SELECT * FROM checks WHERE test_name is not null and test_name<>'' LIMIT 200000000) aa ) bb WHERE bb.rn = 1 and bb.check_status!='failure' LIMIT 12
SELECT bb.* FROM ( SELECT aa.test_name,aa.check_status,row_number() over(partition by test_name order by check_start_time) rn FROM (SELECT * FROM checks WHERE test_name is not null and test_name<>'' LIMIT 200000000) aa ) bb WHERE bb.rn = 1 and bb.check_status<>'failure' LIMIT 12
SELECT bb.* FROM ( SELECT aa.test_name,aa.check_status,row_number() over(partition by test_name) rn FROM (SELECT * FROM checks WHERE test_name is not null and test_name<>'' LIMIT 200000000) aa ) bb WHERE bb.rn = 1 and bb.check_status!='failure' LIMIT 12
SELECT bb.* FROM ( SELECT aa.test_name,aa.check_status,row_number() over(partition by test_name) rn FROM (SELECT * FROM checks WHERE test_name is not null and test_name<>'' LIMIT 200000000) aa LIMIT 12 ) bb WHERE bb.rn = 1 and bb.check_status!='failure' LIMIT 12
SELECT check_name, check_start_time, commit_sha, report_url FROM checks WHERE '2022-04-01' <= check_start_time and test_name ilike '%test_multiple_disks/test.py::test_jbod_overflow%' and check_name ilike '%integration%' and test_status in ('FAIL', 'FLAKY', 'ERROR') order by check_start_time desc
SELECT check_name, test_name AS name, count() AS c, argMax(report_url, check_start_time) FROM checks WHERE check_name LIKE '%State%' AND (test_status LIKE 'F%' OR test_status LIKE 'E%') AND pull_request_number = 0 AND check_start_time >= toDate('2022-11-18') - 7 GROUP BY check_name, name HAVING max(check_start_time) >= toDateTime('2022-11-18 21:48:54') - INTERVAL 48 HOUR ORDER BY c DESC
SELECT check_start_time as d, count(), groupUniqArray(pull_request_number), groupArray(report_url) FROM checks WHERE '2022-06-01' <= check_start_time and test_name like '%test_global_overcommit_tracker%' and test_status in ('FAIL', 'FLAKY') GROUP by d order by d desc
SELECT check_start_time as time, pull_request_number as pr, check_name, report_url, check_status FROM checks WHERE check_name = 'Stateless tests (tsan)' and pull_request_number = 0 and test_name ilike '%tests are not finished%' and check_start_time >= toDate('2022-11-18') - interval 14 day order by check_start_time desc
SELECT check_start_time as time, pull_request_number as pr, check_name, report_url, check_status FROM checks WHERE check_name ilike '%integration%' and check_start_time >= toDate('2022-11-18') - interval 14 day and report_url ilike '%report.html' order by check_start_time desc
SELECT check_start_time as time, pull_request_number as pr, check_name, report_url, check_status FROM checks WHERE check_name ilike '%integration%' and check_start_time >= toDate('2022-11-18') - interval 14 day order by check_start_time desc
SELECT check_start_time as time, pull_request_number as pr, check_name, report_url, check_status FROM checks WHERE check_name like 'Stateless tests (tsan)%' and pull_request_number = 0 and test_name ilike '%tests are not finished%' and check_start_time >= toDate('2022-11-18') - interval 14 day order by check_start_time desc
SELECT check_start_time as time, pull_request_number as pr, check_name, report_url, check_status FROM checks WHERE check_status != 'success' and check_name ilike '%fuzzer%' and check_start_time >= toDate('2022-11-18') - interval 14 day and report_url ilike '%report.html' order by check_start_time desc
SELECT check_start_time as time, pull_request_number as pr, check_name, report_url, check_status FROM checks WHERE pull_request_number = 0 and check_status = 'failure' and test_name ilike '01676_long_clickhouse_client_autocomplete' and check_start_time >= toDate('2022-11-18') - interval 14 day order by check_start_time desc
SELECT check_start_time as time, pull_request_number as pr, check_name, report_url, check_status FROM checks WHERE pull_request_number = 0 and test_name = '01676_long_clickhouse_client_autocomplete' and check_start_time >= toDate('2022-11-18') - interval 14 day and test_status = 'FAIL' order by check_start_time desc
SELECT check_start_time as time, pull_request_number as pr, check_name, report_url, check_status FROM checks WHERE pull_request_number = 0 and test_name = '01676_long_clickhouse_client_autocomplete' and check_start_time >= toDate('2022-11-18') - interval 14 day order by check_start_time desc
SELECT check_start_time as time, pull_request_number as pr, check_name, report_url, check_status FROM checks WHERE pull_request_number = 0 and test_status ilike 'fail' and test_name ilike '01676_long_clickhouse_client_autocomplete' and check_start_time >= toDate('2022-11-18') - interval 14 day order by check_start_time desc
SELECT check_start_time as time, pull_request_number as pr, check_name, report_url, check_status FROM checks WHERE test_name = '01676_long_clickhouse_client_autocomplete' and check_start_time >= toDate('2022-11-18') - interval 14 day and test_status = 'FAIL' order by check_start_time desc
SELECT check_start_time as time, pull_request_number as pr, check_name, report_url, check_status FROM checks WHERE test_name = 'Tests are not finished' and check_start_time >= toDate('2022-11-18') - interval 14 day and report_url ilike '%report.html' order by check_start_time desc
SELECT check_start_time as time, pull_request_number as pr, check_name, report_url, check_status FROM checks WHERE test_name ilike '%tests are not finished%' and check_start_time >= toDate('2022-11-18') - interval 14 day order by check_start_time desc
SELECT check_start_time, report_url FROM checks WHERE check_start_time >= '2022-10-01' and test_name like '%Fatal message in clickhouse-server.log (see fatal_messages.txt)%' and test_status in ('FAIL', 'FLAKY') and report_url like '%msan%' and report_url like '%/0/%' order by check_start_time
SELECT check_start_time, report_url FROM checks WHERE check_start_time >= '2022-11-01' and test_name like '%Fatal message in clickhouse-server.log (see fatal_messages.txt)%' and test_status in ('FAIL', 'FLAKY') and report_url like '%msan%' and report_url like '%/0/%' order by check_start_time desc
SELECT check_start_time, report_url FROM checks WHERE check_start_time >= '2022-11-01' and test_name like '%Fatal message in clickhouse-server.log (see fatal_messages.txt)%' and test_status in ('FAIL', 'FLAKY') and report_url like '%msan%' order by check_start_time
SELECT check_start_time, report_url FROM checks WHERE check_start_time >= '2022-11-01' and test_name like '%Fatal message in clickhouse-server.log (see fatal_messages.txt)%' and test_status in ('FAIL', 'FLAKY') order by check_start_time
SELECT count() runs, countIf(test_status != 'OK') failed, failed/runs failed_q, toDate(check_start_time) d FROM checks WHERE report_url like '%stress_test__msan_%' and check_start_time > toDateTime('2022-11-18 21:48:54') - interval 31 day GROUP by d order by d
SELECT count() runs, countIf(test_status != 'OK') failed, failed/runs failed_q, toDate(check_start_time) d FROM checks WHERE report_url like '%stress_test__msan_%' and check_start_time > toDateTime('2022-11-18 21:48:54') - interval 31 day and test_status != 'OK' GROUP by d order by d
SELECT count() runs, countIf(test_status != 'OK') failed, round(failed/runs, 2) failed_q, toDate(check_start_time) d FROM checks WHERE report_url like '%stress_test__msan_%' and check_start_time > toDateTime('2022-11-18 21:48:54') - interval 31 day GROUP by d order by d
SELECT count() runs, countIf(test_status != 'OK') failed, round(failed/runs, 2) failed_q, toDate(check_start_time) d FROM checks WHERE report_url like '%stress_test__msan_%' and check_start_time between '2022-10-30 00:00:00' and '2022-11-30 00:00:00' GROUP by d order by d
SELECT count() runs, countIf(test_status != 'OK') failed, round(failed/runs, 2)*100 failed_q, toDate(check_start_time) d FROM checks WHERE report_url like '%stress_test__msan_%' and check_start_time > toDateTime('2022-11-18 21:48:54') - interval 31 day GROUP by d order by d
SELECT count(), toDate(check_start_time) d FROM checks WHERE report_url like '%stress_test__msan_%' and check_start_time > toDateTime('2022-11-18 21:48:54') - interval 31 day GROUP by d order by d
SELECT count(), toDate(check_start_time) d FROM checks WHERE report_url like '%stress_test__msan_%' and check_start_time > toDateTime('2022-11-18 21:48:54') - interval 31 day and check_status != 'OK' GROUP by d order by d
SELECT count(), toDate(check_start_time) d FROM checks WHERE report_url like '%stress_test__msan_%' and check_start_time > toDateTime('2022-11-18 21:48:54') - interval 31 day and test_status != 'OK' GROUP by d order by d
SELECT count(), toDate('2022-11-18')-toDate(check_start_time) d FROM checks WHERE report_url like '%stress_test__msan_%' and check_start_time > toDateTime('2022-11-18 21:48:54') - interval 31 day and test_status != 'OK' GROUP by d order by d
SELECT count(*) FROM checks
SELECT count(*) FROM checks LIMIT 12
SELECT count(1) FROM checks
SELECT count(1) FROM checks LIMIT 12
SELECT count(1) FROM checks WHERE test_name <> ''
SELECT count(1) FROM checks WHERE test_name is not null
SELECT count(head_repo) FROM checks
SELECT distinct check_name FROM checks
SELECT distinct check_name FROM checks WHERE check_start_time >= toDate('2022-11-18') - interval 1 day
SELECT distinct check_start_time as time, pull_request_number as pr, check_name, report_url, check_status FROM checks WHERE check_status != 'success' and check_name ilike '%fuzzer%' and check_start_time >= toDate('2022-11-18') - interval 14 day and report_url ilike '%report.html' order by check_start_time desc
SELECT distinct check_start_time as time, pull_request_number as pr, check_name, report_url, check_status FROM checks WHERE check_status != 'success' and check_name ilike '%fuzzer%'and pull_request_number = 0 and check_start_time >= toDate('2022-11-18') - interval 14 day and report_url ilike '%report.html' order by check_start_time desc
SELECT distinct report_url FROM checks WHERE check_start_time >= '2022-11-01' and test_name like '%Fatal message in clickhouse-server.log (see fatal_messages.txt)%' and test_status in ('FAIL', 'FLAKY')
SELECT distinct report_url FROM checks WHERE check_start_time >= '2022-11-01' and test_name like '%Fatal message in clickhouse-server.log (see fatal_messages.txt)%' and test_status in ('FAIL', 'FLAKY') and report_url like '%asan%' and report_url like '%/0/%' order by check_start_time desc
SELECT distinct report_url FROM checks WHERE check_start_time >= '2022-11-01' and test_name like '%Fatal message in clickhouse-server.log (see fatal_messages.txt)%' and test_status in ('FAIL', 'FLAKY') and report_url like '%debug%' order by check_start_time desc
SELECT distinct report_url FROM checks WHERE check_start_time >= '2022-11-01' and test_name like '%Fatal message in clickhouse-server.log (see fatal_messages.txt)%' and test_status in ('FAIL', 'FLAKY') and report_url not like '%msan%'
SELECT distinct report_url FROM checks WHERE check_start_time >= '2022-11-01' and test_name like '%Fatal message in clickhouse-server.log (see fatal_messages.txt)%' and test_status in ('FAIL', 'FLAKY') and report_url not like '%msan%' order by check_start_time desc
SELECT distinct test_status FROM checks
SELECT report_url FROM checks WHERE (test_status LIKE 'F%' OR test_status LIKE 'E%') AND check_start_time >= toDate('2022-11-18') - 7 AND test_name LIKE '%02180_group_by_lowcardinality%'
SELECT report_url, substring(check_name, 1, 15) || '...' || substring(check_name, -15) as check, substring(test_name, -50) as test, check_start_time, test_status, substring(commit_sha, 1, 10) as commit_short, pull_request_number as prnum, multiIf( toDateTime('2022-11-18 21:48:54') - INTERVAL '1' day <= check_start_time, '<1d', toDateTime('2022-11-18 21:48:54') - INTERVAL '7' day <= check_start_time, '<1w', '') as last FROM checks WHERE test_status in ('OK', 'SKIPPED') AND test_name like '%test_query_is_lock_free%' AND toDateTime('2022-11-18 21:48:54') - INTERVAL '10' day <= check_start_time ORDER BY check_start_time DESC LIMIT 20
SELECT report_url, substring(check_name, 1, 15) || '...' || substring(check_name, -15) as check, substring(test_name, -50) as test, check_start_time, test_status, substring(commit_sha, 1, 10) as commit_short, pull_request_number as prnum, multiIf( toDateTime('2022-11-18 21:48:54') - INTERVAL '1' day <= check_start_time, '<1d', toDateTime('2022-11-18 21:48:54') - INTERVAL '7' day <= check_start_time, '<1w', '') as last FROM checks WHERE test_status not in ('OK', 'SKIPPED') AND test_name like '%01072_window_view_multiple_columns_groupby%' AND toDateTime('2022-11-18 21:48:54') - INTERVAL '10' day <= check_start_time AND pull_request_number = 0 ORDER BY pull_request_number == 0, check_start_time DESC LIMIT 20
SELECT report_url, substring(check_name, 1, 15) || '...' || substring(check_name, -15) as check, substring(test_name, -50) as test, check_start_time, test_status, substring(commit_sha, 1, 10) as commit_short, pull_request_number as prnum, multiIf( toDateTime('2022-11-18 21:48:54') - INTERVAL '1' day <= check_start_time, '<1d', toDateTime('2022-11-18 21:48:54') - INTERVAL '7' day <= check_start_time, '<1w', '') as last FROM checks WHERE test_status not in ('OK', 'SKIPPED') AND test_name like '%test_drop_is_lock_free%' AND toDateTime('2022-11-18 21:48:54') - INTERVAL '10' day <= check_start_time ORDER BY check_start_time DESC LIMIT 20
SELECT report_url, substring(check_name, 1, 15) || '...' || substring(check_name, -15) as check, substring(test_name, -50) as test, check_start_time, test_status, substring(commit_sha, 1, 10) as commit_short, pull_request_number as prnum, multiIf( toDateTime('2022-11-18 21:48:54') - INTERVAL '1' day <= check_start_time, '<1d', toDateTime('2022-11-18 21:48:54') - INTERVAL '7' day <= check_start_time, '<1w', '') as last FROM checks WHERE test_status not in ('OK', 'SKIPPED') AND test_name like '%test_grpc_protocol%' AND toDateTime('2022-11-18 21:48:54') - INTERVAL '100' day <= check_start_time AND prnum = 0 ORDER BY check_start_time DESC LIMIT 20
SELECT report_url, substring(check_name, 1, 15) || '...' || substring(check_name, -15) as check, substring(test_name, -50) as test, check_start_time, test_status, test_duration_ms / 1000 AS elapsed_sec, substring(commit_sha, 1, 10) as commit_short, pull_request_number as prnum, multiIf( toDateTime('2022-11-18 21:48:54') - INTERVAL '1' day <= check_start_time, '<1d', toDateTime('2022-11-18 21:48:54') - INTERVAL '7' day <= check_start_time, '<1w', '') as last FROM checks WHERE test_status not in ('OK', 'SKIPPED') AND test_name like '%01072_window_view_multiple_columns_groupby%' AND toDateTime('2022-11-18 21:48:54') - INTERVAL '30' day <= check_start_time ORDER BY check_start_time DESC LIMIT 100
SELECT report_url, substring(check_name, 1, 15) || '...' || substring(check_name, -15) as check, substring(test_name, -50) as test, check_start_time, test_status, test_duration_ms, substring(commit_sha, 1, 10) as commit_short, pull_request_number as prnum, multiIf( toDateTime('2022-11-18 21:48:54') - INTERVAL '1' day <= check_start_time, '<1d', toDateTime('2022-11-18 21:48:54') - INTERVAL '7' day <= check_start_time, '<1w', '') as last FROM checks WHERE test_status not in ('OK', 'SKIPPED') AND test_name like '%01072_window_view_multiple_columns_groupby%' AND toDateTime('2022-11-18 21:48:54') - INTERVAL '30' day <= check_start_time ORDER BY check_start_time DESC LIMIT 100
SELECT test_duration_ms, substring(check_name, 1, 15) || '...' || substring(check_name, -15) as check, substring(test_name, -50) as test, check_start_time, test_status, substring(commit_sha, 1, 10) as commit_short, pull_request_number as prnum, multiIf( toDateTime('2022-11-18 21:48:54') - INTERVAL '1' day <= check_start_time, '<1d', toDateTime('2022-11-18 21:48:54') - INTERVAL '7' day <= check_start_time, '<1w', '') as last FROM checks WHERE test_status in ('OK') AND test_name like '%02275_full_sort_join_long%' AND toDateTime('2022-11-18 21:48:54') - INTERVAL '10' day <= check_start_time AND check_name ilike '%asan%' ORDER BY check_start_time DESC LIMIT 20
SELECT test_duration_ms, substring(check_name, 1, 15) || '...' || substring(check_name, -15) as check, substring(test_name, -50) as test, check_start_time, test_status, substring(commit_sha, 1, 10) as commit_short, pull_request_number as prnum, multiIf( toDateTime('2022-11-18 21:48:54') - INTERVAL '1' day <= check_start_time, '<1d', toDateTime('2022-11-18 21:48:54') - INTERVAL '7' day <= check_start_time, '<1w', '') as last FROM checks WHERE test_status in ('OK') AND test_name like '%02275_full_sort_join_long%' AND toDateTime('2022-11-18 21:48:54') - INTERVAL '10' day <= check_start_time ORDER BY check_start_time DESC LIMIT 20
SELECT test_duration_ms, substring(check_name, 1, 15) || '...' || substring(check_name, -15) as check, substring(test_name, -50) as test, check_start_time, test_status, substring(commit_sha, 1, 10) as commit_short, pull_request_number as prnum, multiIf( toDateTime('2022-11-18 21:48:54') - INTERVAL '1' day <= check_start_time, '<1d', toDateTime('2022-11-18 21:48:54') - INTERVAL '7' day <= check_start_time, '<1w', '') as last FROM checks WHERE test_status not in ('OK', 'SKIPPED') AND test_name like '%02275_full_sort_join_long%' AND toDateTime('2022-11-18 21:48:54') - INTERVAL '10' day <= check_start_time ORDER BY check_start_time DESC LIMIT 20
SELECT test_name AS name, check_name, count() AS c, argMax(report_url, check_start_time) FROM checks WHERE (test_status LIKE 'F%' OR test_status LIKE 'E%') AND pull_request_number = 0 AND check_start_time >= toDate('2022-11-18') - 7 GROUP BY name, check_name HAVING max(check_start_time) >= toDateTime('2022-11-18 21:48:54') - INTERVAL 24 HOUR ORDER BY c DESC
SELECT test_name AS name, replaceOne(report_url, '.html', '/stderr.log'), check_name, report_url, check_start_time, pull_request_number FROM checks WHERE (test_status LIKE 'F%' OR test_status LIKE 'E%') AND check_name like '%Stateless%asan%' --- AND pull_request_number = 0 AND check_start_time >= toDate('2022-11-18') - 60 AND name = 'Tests are not finished' AND check_start_time >= toDateTime('2022-11-18 21:48:54') - INTERVAL 2 DAY ORDER BY check_start_time ASC
SELECT test_name, check_name, toStartOfHour(check_start_time) as d, count(), groupUniqArray(pull_request_number) FROM checks WHERE '2022-03-01' <= check_start_time and check_name like '%ClickHouse Keeper Jepsen%' and test_status in ('FAIL', 'FLAKY', 'ERROR') GROUP by d, test_name, check_name order by d desc
SELECT test_name, check_name, toStartOfHour(check_start_time) as d, count(), groupUniqArray(pull_request_number), any(report_url) FROM checks WHERE '2022-03-01' <= check_start_time and check_name like '%ClickHouse Keeper Jepsen%' and test_status in ('FAIL', 'FLAKY', 'ERROR') GROUP by d, test_name, check_name order by d desc
SELECT test_name, count(), groupUniqArray(pull_request_number), any(report_url) FROM checks WHERE '2022-06-01' <= check_start_time and test_name like '%test_replicated_merge_tree_hdfs_zero_copy%' and test_status in ('FAIL', 'FLAKY') GROUP by test_name
SELECT test_name, count(), max( check_start_time), min( check_start_time) FROM checks WHERE test_name like '%test_query_is_lock_free%' AND toDateTime('2022-11-18 21:48:54') - INTERVAL '100' day <= check_start_time GROUP BY test_name LIMIT 20
SELECT test_name, max( check_start_time), min( check_start_time) FROM checks WHERE test_name like '%test_query_is_lock_free%' AND toDateTime('2022-11-18 21:48:54') - INTERVAL '10' day <= check_start_time GROUP BY test_name LIMIT 20
SELECT test_name, toStartOfDay(check_start_time) as d, count(), groupUniqArray(pull_request_number), any(report_url) FROM checks WHERE '2022-06-01' <= check_start_time and test_name like '%test_keeper_zookeeper_converter%' and test_status in ('FAIL', 'FLAKY') GROUP by d, test_name order by d desc
SELECT test_name, toStartOfHour(check_start_time) as d, count(), groupUniqArray(pull_request_number) FROM checks WHERE '2022-03-01' <= check_start_time and test_name like '%test_backup_restore_on_cluster%' and test_status in ('FAIL', 'FLAKY', 'ERROR') GROUP by d, test_name order by d desc
SELECT test_name, toStartOfHour(check_start_time) as d, count(), groupUniqArray(pull_request_number), any(report_url) FROM checks WHERE '2022-03-01' <= check_start_time and test_name like '%test_backup_restore_on_cluster%test_replicated_database_async' and test_status in ('FAIL', 'FLAKY', 'ERROR') GROUP by d, test_name order by d desc
SELECT toStartOfDay(check_start_time) as d FROM checks WHERE '2022-10-01' <= check_start_time GROUP by d order by d asc
SELECT toStartOfDay(check_start_time) as d, count() FROM checks GROUP by d order by d desc
SELECT toStartOfDay(check_start_time) as d, count() FROM checks WHERE '2022-06-01' <= check_start_time GROUP by d order by d desc
SELECT toStartOfDay(check_start_time) as d, count() FROM checks WHERE '2022-10-01' <= check_start_time GROUP by d order by d asc
SELECT toStartOfDay(check_start_time) as d, count(), avg(round(test_duration_ms/1000)), groupUniqArray(pull_request_number), any(report_url) FROM checks WHERE '2022-06-01' <= check_start_time and test_name like '%01606_git_import%' and check_name like '%tsan%' and test_status in ('FAIL', 'FLAKY', 'OK') GROUP by d order by d desc
SELECT toStartOfDay(check_start_time) as d, count(), avg(round(test_duration_ms/1000)), groupUniqArray(pull_request_number), any(report_url) FROM checks WHERE '2022-06-01' <= check_start_time and test_name like '%01606_git_import%' and test_status in ('FAIL', 'FLAKY') GROUP by d order by d desc
SELECT toStartOfDay(check_start_time) as d, count(), avg(test_duration_ms), groupUniqArray(pull_request_number), any(report_url) FROM checks WHERE '2022-06-01' <= check_start_time and test_name like '%01606_git_import%' and test_status in ('FAIL', 'FLAKY') GROUP by d order by d desc
SELECT toStartOfDay(check_start_time) as d, count(), groupArray(report_url) FROM checks WHERE '2022-06-01' <= check_start_time and test_name like '%test_global_overcommit_tracker%' and test_status in ('FAIL', 'FLAKY') GROUP by d order by d desc
SELECT toStartOfDay(check_start_time) as d, count(), groupUniqArray(pull_request_number), any(report_url) FROM checks WHERE '2022-03-01' <= check_start_time and test_name like '%test_keeper_zookeeper%' and test_status in ('FAIL', 'FLAKY', 'ERROR') GROUP by d order by d desc
SELECT toStartOfDay(check_start_time) as d, count(), groupUniqArray(pull_request_number), any(report_url) FROM checks WHERE '2022-06-01' <= check_start_time and (test_name like '%00993%' or test_name like '%00992%' or test_name like '%01154%') and test_status in ('FAIL', 'FLAKY', 'ERROR') GROUP by d order by d desc
SELECT toStartOfDay(check_start_time) as d, count(), groupUniqArray(pull_request_number), any(report_url) FROM checks WHERE '2022-06-01' <= check_start_time and test_name like '%test_global_overcommit_tracker%' and test_status in ('FAIL', 'FLAKY') and pull_request_number=0 GROUP by d order by d desc
SELECT toStartOfDay(check_start_time) as d, count(), groupUniqArray(pull_request_number), any(report_url) FROM checks WHERE '2022-06-01' <= check_start_time and test_name like '%test_global_overcommit_tracker%' and test_status in ('FLAKY') GROUP by d order by d desc
SELECT toStartOfDay(check_start_time) as d, count(), groupUniqArray(pull_request_number), groupArray(report_url) FROM checks WHERE '2022-06-01' <= check_start_time and test_name like '%test_global_overcommit_tracker%' and test_status in ('FAIL', 'FLAKY') GROUP by d order by d desc
SELECT toStartOfHour(check_start_time) as d, count(), groupUniqArray(pull_request_number) FROM checks WHERE '2022-03-01' <= check_start_time and check_name like '%ClickHouse Stress Test (tsan)%' and test_status in ('FAIL', 'FLAKY', 'ERROR') GROUP by d order by d desc
SELECT toStartOfHour(check_start_time) as d, count(), groupUniqArray(pull_request_number) FROM checks WHERE '2022-03-01' <= check_start_time and test_name like '%test_keeper_map%' and test_status in ('FAIL', 'FLAKY', 'ERROR') GROUP by d order by d desc
SELECT toStartOfHour(check_start_time) as d, count(), groupUniqArray(pull_request_number), any(report_url) FROM checks WHERE '2022-03-01' <= check_start_time and test_name like '%test_keeper_zookeeper%' and test_status in ('FAIL', 'FLAKY', 'ERROR') GROUP by d order by d desc
SELECT toStartOfHour(check_start_time) as d, count(), groupUniqArray(pull_request_number), any(report_url) FROM checks WHERE '2022-06-01' <= check_start_time and test_name like '%manual_write_to_replicas%' and test_status in ('SKIPPED') GROUP by d order by d desc
SELECT toStartOfHour(check_start_time) as d, count(), groupUniqArray(pull_request_number), check_name FROM checks WHERE '2022-03-01' <= check_start_time and test_name like '%test_keeper_zookeeper%' and test_status in ('FAIL', 'FLAKY', 'ERROR') GROUP by d, check_name order by d desc
SELECT toStartOfHour(check_start_time) as d, count(), groupUniqArray(pull_request_number), check_name, any(report_url) FROM checks WHERE '2022-03-01' <= check_start_time and test_name like '%test_keeper_zookeeper%' and test_status in ('FAIL', 'FLAKY', 'ERROR') GROUP by d, check_name order by d desc
SELECT toStartOfHour(check_start_time) as d, count(), groupUniqArray(pull_request_number), groupArray(report_url) FROM checks WHERE '2022-06-01' <= check_start_time and test_name like '%test_global_overcommit_tracker%' and test_status in ('FAIL', 'FLAKY') GROUP by d order by d desc
SELECT toStartOfHour(check_start_time) as d, count(), groupUniqArray(pull_request_number), test_name, check_name FROM checks WHERE '2022-03-01' <= check_start_time and check_name like '%(tsan)%' and test_status in ('FAIL', 'FLAKY', 'ERROR') GROUP by d, test_name, check_name order by d desc
SELECT toStartOfHour(check_start_time) as d, count(), groupUniqArray(pull_request_number), test_name, check_name, any(report_url) FROM checks WHERE '2022-03-01' <= check_start_time and check_name like '%Stress test (tsan)%' and test_name like '%Cannot start clickhouse-server%' and test_status in ('FAIL', 'FLAKY', 'ERROR') GROUP by d, test_name, check_name order by d desc
SELECT toStartOfHour(check_start_time) as d, count(), groupUniqArray(pull_request_number), test_name, check_name, any(report_url) FROM checks WHERE '2022-03-01' <= check_start_time and check_name like '%Stress test (tsan)%' and test_status in ('FAIL', 'FLAKY', 'ERROR') GROUP by d, test_name, check_name order by d desc
SELECT toStartOfHour(check_start_time) as d, d - toDateTime('2022-11-18 21:48:54'), count(), groupUniqArray(pull_request_number), groupArray(report_url) FROM checks WHERE '2022-06-01' <= check_start_time and test_name like '%test_global_overcommit_tracker%' and test_status in ('FAIL', 'FLAKY') GROUP by d order by d desc
SELECT toStartOfHour(check_start_time) as d, d - toStartOfHour(toDateTime('2022-11-18 21:48:54')), count(), groupUniqArray(pull_request_number), groupArray(report_url) FROM checks WHERE '2022-06-01' <= check_start_time and test_name like '%test_global_overcommit_tracker%' and test_status in ('FAIL', 'FLAKY') GROUP by d order by d desc
SELECT toStartOfMonth(check_start_time) AS d, count() AS c FROM checks GROUP BY d ORDER BY d
SELECT toStartOfMonth(check_start_time) as month, sum(case test_status when 'ERROR' then 1 else 0 end) Error, count() Total, (Error / Total) Ratio FROM checks WHERE toDateTime(check_start_time) >= toDateTime('2022-11-18 21:48:54') - INTERVAL 6 Month AND check_name LIKE '%Jepsen%' GROUP BY month ORDER BY month DESC
SELECT toStartOfWeek(check_start_time) AS d, count() AS c, uniq(check_name), sum(check_duration_ms) FROM checks WHERE test_name = '' GROUP BY d ORDER BY d
(SELECT * FROM (SELECT date, SUM(new_tested) FROM covid WHERE location_key = 'RU' GROUP BY date) AS ru JOIN (SELECT date, SUM(new_tested) FROM covid WHERE location_key = 'KZ' GROUP BY date) AS kz ON ru.date = kz.date )
(SELECT * FROM (SELECT date, SUM(new_tested) as new_tested FROM covid WHERE location_key = 'RU' GROUP BY date) AS ru INNER JOIN (SELECT date, SUM(new_tested) as new_tested FROM covid WHERE location_key = 'KZ' GROUP BY date) AS kz ON ru.date = kz.date )
(SELECT date, `sum(new_tested)` AS ru_test, `kz.sum(new_tested)` AS kz_test FROM (SELECT date, SUM(new_tested) FROM covid WHERE location_key = 'RU' GROUP BY date) AS ru JOIN (SELECT date, SUM(new_tested) FROM covid WHERE location_key = 'KZ' GROUP BY date) AS kz ON ru.date = kz.date )
SELECT "radio", "samples", Max("samples") FROM "cell_towers" WHERE "radio"='LTE' and "created">= '2017-01-01' GROUP BY "samples", "radio", "created" ORDER BY MAX ("samples"), "radio", "created" desc
SELECT "radio", "samples", Max(samples) FROM "cell_towers" WHERE "radio"='LTE' and "created"> '2017-01-01' GROUP BY "samples", "radio", "created" ORDER BY MAX ("samples"), "radio", "created" asc
SELECT "radio", "samples", Max(samples) FROM "cell_towers" WHERE "radio"='LTE' and "created"> '2017-01-01' GROUP BY "samples", "radio", "created" ORDER BY MAX ("samples"), "radio", "created" desc
SELECT "radio", "samples", Max(samples) FROM "cell_towers" WHERE "radio"='LTE' and "created"> 2017-01-01 GROUP BY "samples", "radio" ORDER BY MAX ("samples") DESC
SELECT "radio", "samples", Max(samples) FROM "cell_towers" WHERE "radio"='LTE' and "created"> 2017-01-01 GROUP BY "samples", "radio", "created" ORDER BY MAX ("samples") DESC
SELECT "radio", "samples", Max(samples) FROM "cell_towers" WHERE "radio"='LTE' and "created"> 2017-01-01 GROUP BY "samples", "radio", "created" ORDER BY MAX ("samples"), "created"
SELECT "radio", "samples", Max(samples) FROM "cell_towers" WHERE "radio"='LTE' and "created"> 2017-01-01 GROUP BY "samples", "radio", "created" ORDER BY MAX ("samples"), "created" DESC
SELECT "radio", "samples", Max(samples) FROM "cell_towers" WHERE "radio"='LTE' and "created"> 2017-01-01 GROUP BY "samples", "radio", "created" ORDER BY MAX ("samples"), "radio" desc
SELECT 'net','range',max(cnt=1) as net_to_range from( SELECT net,count(distinct range) cnt FROM cell_towers GROUP by net ) LIMIT 100
SELECT (intDiv(toUInt32(created), 2) * 2) * 1000 as t, count() FROM default.cell_towers WHERE created >= toDateTime(1669210240) AND created <= toDateTime(1669213840) GROUP BY t ORDER BY t
SELECT * FROM blogs.forex LIMIT 100
SELECT * APPLY(toJSONString) FROM reddit LIMIT 5
SELECT * EXCEPT (subreddit) FROM reddit LIMIT 5
SELECT * FROM ( SELECT * FROM github_events WHERE ilike(body, '%b201%') or ilike(body, '%b101%') or ilike(body, '%b301%') or ilike(body, '%b601%') ) as t1 inner join ( SELECT distinct full_name as repo_name, language, max(stargazers_count) as cnt FROM repos WHERE (language == 'Python') and (stargazers_count >= 0) and (stargazers_count <= 20000) GROUP by full_name, language order by cnt desc ) as t2 using (repo_name)
SELECT * FROM ( SELECT * FROM github_events WHERE ilike(body, '%b201%') or ilike(body, '%b101%') or ilike(body, '%b301%') or ilike(body, '%b601%') ) as t1 left join ( SELECT distinct full_name as repo_name, language, max(stargazers_count) as cnt FROM repos WHERE (language == 'Python') and (stargazers_count >= 0) and (stargazers_count <= 200) GROUP by full_name, language order by cnt desc ) as t2 using (repo_name)
SELECT * FROM ( SELECT * FROM github_events WHERE ilike(body, '%b201%') or ilike(body, '%b101%') or ilike(body, '%b301%') or ilike(body, '%b601%') ) as t1 left join ( SELECT distinct full_name as repo_name, language, max(stargazers_count) as cnt FROM repos WHERE (language == 'Python') and (stargazers_count >= 150) and (stargazers_count <= 200) GROUP by full_name, language order by cnt desc ) as t2 using (repo_name) WHERE (language == 'Python')
SELECT * FROM ( SELECT * FROM github_events WHERE ilike(body, '%b201%') or ilike(body, '%b101%') or ilike(body, '%b301%') or ilike(body, '%b601%') ) as t1 right join ( SELECT distinct full_name as repo_name, language, max(stargazers_count) as cnt FROM repos WHERE (language == 'Python') and (stargazers_count >= 0) and (stargazers_count <= 20000) GROUP by full_name, language order by cnt desc ) as t2 using (repo_name)
SELECT * FROM ( SELECT *, (`count` * 100) / sum(`count`) OVER (ORDER BY Null) AS `percent` FROM ( SELECT `NER`, count(`NER`) AS `count` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, `NER` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, arrayJoin(`NER`) AS `NER` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, `NER` FROM default.`recipes` ) t4 ) t3 ) t2 GROUP BY `NER` ) t1 ) t0 ORDER BY `count` DESC LIMIT 500
SELECT * FROM ( SELECT *, (`count` * 100) / sum(`count`) OVER (ORDER BY Null) AS `percent` FROM ( SELECT lower(`NER`) AS `NER_lower`, count(lower(`NER`)) AS `count` FROM ( SELECT `NER`, lower(`NER`) AS `NER_lower`, `count`, `percent` FROM ( SELECT * FROM ( SELECT *, (`count` * 100) / sum(`count`) OVER (ORDER BY Null) AS `percent` FROM ( SELECT `NER`, count(`NER`) AS `count` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, `NER` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, arrayJoin(`NER`) AS `NER` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, `NER` FROM default.`recipes` ) t8 ) t7 ) t6 GROUP BY `NER` ) t5 ) t4 ORDER BY `count` DESC ) t3 ) t2 GROUP BY `NER_lower` ) t1 ) t0 ORDER BY `count` DESC LIMIT 500
SELECT * FROM ( SELECT *, (`count` * 100) / sum(`count`) OVER (ORDER BY Null) AS `percent` FROM ( SELECT lower(`NER`) AS `NER_lower`, count(lower(`NER`)) AS `count` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, `NER`, lower(`NER`) AS `NER_lower` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, arrayJoin(`NER`) AS `NER` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, `NER` FROM default.`recipes` ) t4 ) t3 ) t2 GROUP BY `NER_lower` ) t1 ) t0 ORDER BY `count` DESC LIMIT 500
SELECT * FROM ( SELECT UserID, count(1) as hitCount FROM hits GROUP by UserID ) as sq WHERE hitCount > 100
SELECT * FROM ( SELECT UserID, count(1) as hitCount FROM hits WHERE UserID = 2855564236250770534 GROUP by UserID ) as sq WHERE hitCount > 150
SELECT * FROM ( SELECT repo_name, count() AS stars FROM github_events WHERE event_type = 'WatchEvent' GROUP BY repo_name HAVING stars <=200 ) AS t1 INNER JOIN ( SELECT repo_name, arrayJoin(labels) AS label, count() AS c FROM github_events WHERE (event_type IN ('CreateEvent', 'CommitCommentEvent', 'PullRequestEvent', 'IssuesEvent')) AND (action IN ('created', 'opened', 'labeled')) AND ((label ILIKE '%python%')) GROUP BY repo_name, label ) AS t2 USING (repo_name) ORDER BY c DESC
SELECT * FROM ( SELECT repo_name, count() AS stars FROM github_events WHERE event_type = 'WatchEvent' GROUP BY repo_name HAVING stars <=200 ) AS t1 INNER JOIN ( SELECT repo_name, arrayJoin(labels) AS label, count() AS c FROM github_events WHERE (event_type IN ('CreateEvent', 'CommitCommentEvent', 'PullRequestEvent', 'IssuesEvent')) AND (action IN ('created', 'opened', 'labeled')) AND ((label ILIKE '%python%')) GROUP BY repo_name, label HAVING c >= 30 ) AS t2 USING (repo_name) ORDER BY stars DESC
SELECT * FROM ( SELECT repo_name, count() AS stars FROM github_events WHERE event_type = 'WatchEvent' GROUP BY repo_name HAVING stars <=200 ) AS t1 INNER JOIN ( SELECT repo_name, arrayJoin(labels) AS label, count() AS c FROM github_events WHERE (event_type IN ('CreateEvent', 'CommitCommentEvent', 'PullRequestEvent', 'IssuesEvent')) AND (action IN ('created', 'opened', 'labeled')) AND ((label ILIKE '%python%')) GROUP BY repo_name, label ORDER BY c DESC ) AS t2 USING (repo_name)
SELECT * FROM ( SELECT repo_name, count() AS stars FROM github_events WHERE event_type = 'WatchEvent' GROUP BY repo_name HAVING stars <=200 ) AS t1 INNER JOIN ( SELECT repo_name, arrayJoin(labels) AS label, count() AS c FROM github_events WHERE (event_type IN ('CreateEvent', 'CommitCommentEvent', 'PullRequestEvent', 'IssuesEvent')) AND (action IN ('created', 'opened', 'labeled')) AND ((label ILIKE '%python%')) GROUP BY repo_name, label ORDER BY c DESC ) AS t2 USING (repo_name) ORDER BY c DESC
SELECT * FROM ( SELECT repo_name, count() AS stars FROM github_events WHERE event_type = 'WatchEvent' GROUP BY repo_name HAVING stars <=200 ) AS t1 INNER JOIN ( SELECT repo_name, arrayJoin(labels) AS label, count() AS c FROM github_events WHERE (event_type IN ('CreateEvent', 'CommitCommentEvent', 'PullRequestEvent', 'IssuesEvent')) AND (action IN ('created', 'opened', 'labeled')) AND ((label ILIKE '%python%')) GROUP BY repo_name, label ORDER BY c DESC ) AS t2 USING (repo_name) ORDER BY stars DESC
SELECT * FROM ( SELECT repo_name, count() AS stars FROM github_events WHERE event_type = 'WatchEvent' GROUP BY repo_name ORDER BY stars DESC ) AS t1 INNER JOIN ( SELECT repo_name, arrayJoin(labels) AS label, count() AS c FROM github_events WHERE (event_type IN ('CreateEvent', 'CommitCommentEvent', 'PullRequestEvent', 'IssuesEvent')) AND (action IN ('created', 'opened', 'labeled')) AND ((label ILIKE '%python%')) GROUP BY repo_name, label ORDER BY c DESC ) AS t2 USING (repo_name)
SELECT * FROM ( SELECT repo_name, count() AS stars FROM github_events WHERE event_type = 'WatchEvent' GROUP BY repo_name ORDER BY stars DESC LIMIT 50 ) AS t1 INNER JOIN ( SELECT repo_name, arrayJoin(labels) AS label, count() AS c FROM github_events WHERE (event_type IN ('CreateEvent', 'CommitCommentEvent', 'PullRequestEvent', 'IssuesEvent')) AND (action IN ('created', 'opened', 'labeled')) AND ((label ILIKE '%python%')) GROUP BY repo_name, label ORDER BY c DESC LIMIT 50 ) AS t2 USING (repo_name)
SELECT * FROM (SELECT * FROM (SELECT date, SUM(new_tested) FROM covid WHERE location_key = 'RU' GROUP BY date) AS ru JOIN (SELECT date, SUM(new_tested) FROM covid WHERE location_key = 'KZ' GROUP BY date) AS kz ON ru.date = kz.date )
SELECT * FROM (SELECT CounterID,row_number() over (partition by CounterID) as rn, count(*) over (partition by CounterID) AS cn FROM hits) WHERE rn = 1 order by cn desc LIMIT 10
SELECT * FROM (SELECT date, SUM(new_tested) FROM covid WHERE location_key = 'RU' GROUP BY date) AS ru JOIN (SELECT date, SUM(new_tested) FROM covid WHERE location_key = 'KZ' GROUP BY date) AS kz ON ru.date = kz.date
SELECT * FROM (SELECT date, groupArray( (location_key, new_tested) ) AS state FROM (SELECT date, location_key, SUM(new_tested) AS new_tested FROM covid GROUP BY date, location_key) WHERE location_key in ('RU', 'KZ', 'BY') GROUP BY date) WHERE arrayAll(l->l.2>0, state)
SELECT * FROM (SELECT date, groupArray( (location_key, new_tested) ) AS state FROM (SELECT date, location_key, SUM(new_tested) AS new_tested FROM covid GROUP BY date, location_key) WHERE location_key in ('RU', 'KZ', 'BY') GROUP BY date) WHERE arrayFirstIndex(l->l.2=0, state) = 1 AND arrayLastIndex(l->l.2=0, state) = 1
SELECT * FROM (SELECT date, new_tested as new_tested FROM covid WHERE location_key = 'RU') AS ru INNER JOIN (SELECT date, new_tested as new_tested FROM covid WHERE location_key = 'KZ') AS kz ON ru.date = kz.date
SELECT * FROM (SELECT sum(new_tested) as new_tested, date FROM covid WHERE location_key = 'RU' GROUP BY date) as ru Inner Join (SELECT sum(new_tested) as new_tested, date FROM covid WHERE location_key = 'KZ' GROUP BY date) as kz ON ru.date = kz.date WHERE ru.new_tested < kz.new_tested
SELECT * FROM `blogs`.`forex` LIMIT 101
SELECT * FROM `default`.`github_events` LIMIT 101
SELECT * FROM benchmark_runs LIMIT 10
SELECT * FROM blogs.countries LIMIT 1
SELECT * FROM blogs.countries LIMIT 10
SELECT * FROM blogs.countries WHERE ( name IS NOT NULL ) LIMIT 100
SELECT * FROM blogs.country_codes LIMIT 10
SELECT * FROM blogs.country_codes LIMIT 100
SELECT * FROM blogs.forex f LIMIT 100
SELECT * FROM blogs.hackernews_json LIMIT 100
SELECT * FROM blogs.hackernews_json_v2 LIMIT 100
SELECT * FROM blogs.hackernews_json_v2 hjv LIMIT 100
SELECT * FROM blogs.http_logs LIMIT 1
SELECT * FROM blogs.http_logs LIMIT 100
SELECT * FROM blogs.noaa ORDER BY station_id, date LIMIT 10 --SHOW CREATE TABLE blogs.noaa --SELECT * FROM blogs.stations --ORDER BY country_code, state, station_id --LIMIT 16384,1
SELECT * FROM blogs.noaa_v2 nv order by nv.`date` DESC LIMIT 500
SELECT * FROM blogs.resorts LIMIT 100
SELECT * FROM blogs.states LIMIT 2
SELECT * FROM blogs.stations
SELECT * FROM blogs.stations ORDER BY country_code, state, station_id LIMIT 3 --SHOW CREATE TABLE blogs.stations
SELECT * FROM cell_towers ORDER BY created ASC
SELECT * FROM cell_towers ORDER BY created DESC
SELECT * FROM cell_towers ORDER BY lat
SELECT * FROM cell_towers ORDER BY lat DESC
SELECT * FROM cell_towers WHERE 54 < lat < 56 AND 54 < lon < 56 AND radio = 'GSM' ORDER BY lat, lon DESC
SELECT * FROM cell_towers WHERE 54 < lat < 56 AND lon > 54 AND radio = 'GSM' ORDER BY lat, lon DESC
SELECT * FROM cell_towers WHERE area = 3754 AND net = 1 ORDER BY mcc DESC
SELECT * FROM cell_towers WHERE area='32971'
SELECT * FROM cell_towers WHERE area=30440
SELECT * FROM cell_towers WHERE area=30440 AND mcc=250
SELECT * FROM cell_towers WHERE area=30440 AND mcc=250 AND cell=1041
SELECT * FROM cell_towers WHERE cell='138116611'
SELECT * FROM cell_towers WHERE created = updated AND lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56
SELECT * FROM cell_towers WHERE created > '2017-01-01'
SELECT * FROM cell_towers WHERE created > 2017-01-01
SELECT * FROM cell_towers WHERE created > 2017-01-01 AND radio = 'LTE'
SELECT * FROM cell_towers WHERE created > 2017-01-01 ORDER BY samples DESC
SELECT * FROM cell_towers WHERE lat > '54' AND lat < '56'
SELECT * FROM cell_towers WHERE lat > '67'
SELECT * FROM cell_towers WHERE lat > 0 AND lon > 0
SELECT * FROM cell_towers WHERE lat > 0 AND lon > 0 AND radio = 'GSM'
SELECT * FROM cell_towers WHERE lat > 0 AND lon > 0 AND radio = 'GSM' ORDER BY lat DESC, lon DESC
SELECT * FROM cell_towers WHERE lat > 0 AND lon > 0 AND radio = 'GSM' ORDER BY lat, lon DESC
SELECT * FROM cell_towers WHERE lat > 54 AND lat < 56 AND lon > 54 AND lon < 56
SELECT * FROM cell_towers WHERE lat > 54 AND lat < 56 AND lon > 54 AND lon < 56 ORDER BY (created) DESC
SELECT * FROM cell_towers WHERE lat > 54 AND lat < 56 AND lon > 54 AND lon < 56 ORDER BY (samples) DESC
SELECT * FROM cell_towers WHERE lat > 54 AND lat < 56 AND lon > 54 AND lon < 56 ORDER BY cell
SELECT * FROM cell_towers WHERE lat > 54 and lat < 56 and lon > 54 and lon < 56
SELECT * FROM cell_towers WHERE lat > 54 and lat < 56 and lon > 54 and lon < 56 and radio = 'GSM'
SELECT * FROM cell_towers WHERE lat > 54 and lat < 56 and lon > 54 and lon < 56 and radio = 'GSM' and mcc = 250 AND area = 30440 AND cell = 1041
SELECT * FROM cell_towers WHERE lat > 66 AND created >= '2020-06-01'
SELECT * FROM cell_towers WHERE lat > 66 AND created >= '2020-06-01' ORDER BY area ASC
SELECT * FROM cell_towers WHERE lat > 66 AND created >= '2020-06-01' ORDER BY created ASC
SELECT * FROM cell_towers WHERE lat > 67 ORDER BY radio DESC
SELECT * FROM cell_towers WHERE lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56 ORDER BY created ASC
SELECT * FROM cell_towers WHERE lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56 ORDER BY created DESC
SELECT * FROM cell_towers WHERE lat BETWEEN 54 AND 56
SELECT * FROM cell_towers WHERE lat BETWEEN 54 AND 56 AND lon BETWEEN 54 AND 56
SELECT * FROM cell_towers WHERE lat> 66 and created> '2020-06-01' ORDER BY area ASC
SELECT * FROM cell_towers WHERE lat>67 ORDER BY radio
SELECT * FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56
SELECT * FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56 and radio = 'GSM'
SELECT * FROM cell_towers WHERE lon >= 54 AND lon <= 56 AND lat >= 54 AND lat <= 56
SELECT * FROM cell_towers WHERE lon >= 54 AND lon <= 56 AND lat >= 54 AND lat <= 56 AND created = updated
SELECT * FROM cell_towers WHERE mcc = 250 AND area = 30440 AND cell = 1041
SELECT * FROM cell_towers WHERE mcc = 250 AND area = 30440 AND cell = 1041 ORDER BY radio
SELECT * FROM cell_towers WHERE mcc = 250 AND area = 30440 ORDER BY cell ASC
SELECT * FROM cell_towers WHERE mcc = 255 and area = 30440
SELECT * FROM cell_towers WHERE mcc = 255 and area = 30440 and cell = 1041
SELECT * FROM cell_towers WHERE mcc = 724 order by radio desc LIMIT 100
SELECT * FROM cell_towers WHERE mcc='250' AND area='30440' AND cell='1041'
SELECT * FROM cell_towers WHERE mcc=250
SELECT * FROM cell_towers WHERE mcc=250 AND area=30444
SELECT * FROM cell_towers WHERE radio = 'GSM'
SELECT * FROM cell_towers WHERE radio = 'GSM' AND lat > 54 AND lat < 56 AND lon > 54 AND lon < 56
SELECT * FROM cell_towers WHERE radio = 'GSM' AND lat > 54 AND lat < 56 AND lon > 54 AND lon < 56 ORDER BY radio
SELECT * FROM cell_towers WHERE radio = 'GSM' AND lat > 66 AND created = '2020-06-01' ORDER BY area ASC
SELECT * FROM cell_towers WHERE radio = 'GSM' AND lat > 66 AND created > 2020-06-01 ORDER BY area ASC
SELECT * FROM cell_towers WHERE radio = 'GSM' AND lat > 66 AND created > 2020-06-01 ORDER BY area DESC
SELECT * FROM cell_towers WHERE radio = 'GSM' AND lat > 66 ORDER BY area ASC
SELECT * FROM cell_towers WHERE radio = 'GSM' AND lon >= 54 AND lon <= 56
SELECT * FROM cell_towers WHERE radio = 'GSM' AND lon >= 54 AND lon <= 56 AND lat >= 54 AND lat <= 56
SELECT * FROM cell_towers WHERE radio = 'GSM' AND mcc = 250 AND cell = 1041 AND lat > 54 AND lat < 56 AND lon > 54 AND lon < 56
SELECT * FROM cell_towers WHERE radio = 'GSM' AND mcc = 250 AND lat > 54 AND lat < 56 AND lon > 54 AND lon < 56
SELECT * FROM cell_towers WHERE radio = 'GSM' AND net = 1 ORDER BY mcc DESC
SELECT * FROM cell_towers WHERE radio = 'GSM' ORDER BY area ASC
SELECT * FROM cell_towers WHERE radio = 'GSM' ORDER BY mcc DESC
SELECT * FROM cell_towers WHERE radio = 'GSM' ORDER BY samples ASC
SELECT * FROM cell_towers WHERE radio = 'GSM' ORDER BY samples DESC
SELECT * FROM cell_towers WHERE radio = 'GSM' and lon > 54 and lon < 56
SELECT * FROM cell_towers WHERE radio = 'GSM' and lon > 54 and lon < 56 and lat > 54 and lat < 56
SELECT * FROM cell_towers WHERE radio = 'LTE' AND created < 2017-01-01 ORDER BY samples DESC
SELECT * FROM cell_towers WHERE radio = 'LTE' AND created > '2017-01-01' ORDER BY samples DESC
SELECT * FROM cell_towers WHERE radio = 'LTE' AND created > 2017-01-01 ORDER BY samples DESC
SELECT * FROM cell_towers WHERE radio = 'LTE' and created > '2017-01-01'
SELECT * FROM cell_towers WHERE radio = 'UMTS' AND area = 3754
SELECT * FROM cell_towers WHERE radio = 'UMTS' AND area = 3754 ORDER BY mcc DESC
SELECT * FROM cell_towers WHERE radio = 'UMTS' ORDER BY samples
SELECT * FROM cell_towers WHERE radio= 'GSM' AND lat>'0' AND lon>'0'
SELECT * FROM cell_towers WHERE updated = created
SELECT * FROM cell_towers Where mcc='250' and area = '30440' and cell='1041' GROUP by radio, mcc, area,cell,net,unit,lon,lat,range,samples,changeable, created,updated,averageSignal
SELECT * FROM cell_towers order by radio desc LIMIT 100
SELECT * FROM covid WHERE ( new_tested IS NOT NULL ) LIMIT 100
SELECT * FROM covid WHERE new_confirmed=12
SELECT * FROM covid order by cumulative_tested
SELECT * FROM covid order by cumulative_tested desc
SELECT * FROM covid order by cumulative_tested desc LIMIT 19
SELECT * FROM covid order by date
SELECT * FROM default.`recipes` LIMIT 500
SELECT * FROM default.benchmark_results
SELECT * FROM default.benchmark_results LIMIT 10
SELECT * FROM default.benchmark_results LIMIT 100
SELECT * FROM default.benchmark_runs
SELECT * FROM default.benchmark_runs LIMIT 10
SELECT * FROM default.checks
SELECT * FROM default.checks LIMIT 100
SELECT * FROM default.covid LIMIT 100
SELECT * FROM default.food_facts LIMIT 100
SELECT * FROM default.hits
SELECT * FROM default.hits LIMIT 100
SELECT * FROM default.hits order by EventTime LIMIT 10
SELECT * FROM default.hits order by EventTime desc LIMIT 10
SELECT * FROM default.menu LIMIT 10
SELECT * FROM default.menu_item LIMIT 10
SELECT * FROM default.menu_page
SELECT * FROM dish WHERE description <> ''
SELECT * FROM dish WHERE id = 123
SELECT * FROM dish WHERE name <> ''
SELECT * FROM dish WHERE name = ''
SELECT * FROM dns LIMIT 1
SELECT * FROM dns LIMIT 10
SELECT * FROM dns WHERE domain ILIKE '%.com'
SELECT * FROM dns WHERE domain ILIKE '%msappproxy.net'
SELECT * FROM dns WHERE domain ILIKE '%msappproxy.net' LIMIT 10
SELECT * FROM dns WHERE domain like '1%'
SELECT * FROM dns2
SELECT * FROM food_facts LIMIT 1
SELECT * FROM food_facts LIMIT 10
SELECT * FROM git_clickhouse."file_changes" LIMIT 30 OFFSET 0
SELECT * FROM git_clickhouse.commits LIMIT 10
SELECT * FROM git_clickhouse.commits LIMIT 100
SELECT * FROM git_clickhouse.commits c
SELECT * FROM git_clickhouse.file_changes LIMIT 100
SELECT * FROM github_events LIMIT 1
SELECT * FROM github_events LIMIT 10
SELECT * FROM github_events LIMIT 100
SELECT * FROM github_events LIMIT 5 -- show tables
SELECT * FROM github_events WHERE (event_type = 'IssuesEvent' or event_type = 'IssueCommentEvent' or event_type = 'CommitCommentEvent') and (repo_name = 'ReOpen/libmdbx' or repo_name = 'leo-yuriev/libmdbx' or repo_name = 'erthink/libmdbx') ORDER BY created_at
SELECT * FROM github_events WHERE (event_type = 'IssuesEvent' or event_type = 'IssueCommentEvent') and (repo_name = 'ReOpen/libmdbx' or repo_name = 'leo-yuriev/libmdbx' or repo_name = 'erthink/libmdbx') ORDER BY created_at
SELECT * FROM github_events WHERE (event_type = 'IssuesEvent' or event_type = 'IssueCommentEvent') and (repo_name = 'leo-yuriev/libmdbx' or repo_name = 'erthink/libmdbx') ORDER BY created_at ASC LIMIT 10
SELECT * FROM github_events WHERE (repo_name = 'ReOpen/libmdbx' or repo_name = 'leo-yuriev/libmdbx' or repo_name = 'erthink/libmdbx') and actor_login = 'erthink' order by updated_at desc
SELECT * FROM github_events WHERE (repo_name = 'ReOpen/libmdbx' or repo_name = 'leo-yuriev/libmdbx' or repo_name = 'erthink/libmdbx') and body LIKE '%Исходя из наблюдаемого в серии экспериментов%'
SELECT * FROM github_events WHERE (repo_name = 'ReOpen/libmdbx' or repo_name = 'leo-yuriev/libmdbx' or repo_name = 'erthink/libmdbx') and title LIKE '%Oh, I see. Thank you for your input!%'
SELECT * FROM github_events WHERE (repo_name = 'ReOpen/libmdbx' or repo_name = 'leo-yuriev/libmdbx' or repo_name = 'erthink/libmdbx') order by updated_at desc LIMIT 30
SELECT * FROM github_events WHERE (repo_name = 'apache/pulsar') AND (event_type IN ('PullRequestEvent', 'PullRequestReviewCommentEvent', 'PullRequestReviewEvent', 'IssueCommentEvent')) AND (number = 9276)
SELECT * FROM github_events WHERE (repo_name = 'apache/pulsar') AND (toString(event_type) IN ('PullRequestEvent', 'PullRequestReviewCommentEvent', 'PullRequestReviewEvent', 'IssueCommentEvent')) AND (number = 9276)
SELECT * FROM github_events WHERE action != 'none' LIMIT 100
SELECT * FROM github_events WHERE action != 'none' and body ILIKE '%bandit%' LIMIT 1000
SELECT * FROM github_events WHERE actor_login = 'Sorck'
SELECT * FROM github_events WHERE actor_login = 'Sorck' LIMIT 5 -- show tables
SELECT * FROM github_events WHERE actor_login = 'duyet' and repo_name like 'google%'
SELECT * FROM github_events WHERE actor_login = 'duyetdev' and repo_name = 'google/coding-with-chrome'
SELECT * FROM github_events WHERE body ILIKE '%B201%' LIMIT 1000
SELECT * FROM github_events WHERE body ILIKE '%ClickHouse%' AND repo_name = '996icu/996.ICU'
SELECT * FROM github_events WHERE created_at >= '2022-11-26' --GROUP BY repo_name LIMIT 15
SELECT * FROM github_events WHERE created_at::Date < '2014-01-16' AND event_type = 'WatchEvent' AND actor_login = 'sergey-alekseev'
SELECT * FROM github_events WHERE event_type = 'IssueCommentEvent' and (repo_name = 'leo-yuriev/libmdbx' or repo_name = 'erthink/libmdbx') ORDER BY created_at ASC LIMIT 100
SELECT * FROM github_events WHERE event_type = 'IssuesEvent' ORDER BY rand() LIMIT 50
SELECT * FROM github_events WHERE event_type = 'IssuesEvent' and (repo_name = 'leo-yuriev/libmdbx' or repo_name = 'erthink/libmdbx') ORDER BY created_at ASC
SELECT * FROM github_events WHERE event_type = 'IssuesEvent' and (repo_name = 'leo-yuriev/libmdbx' or repo_name = 'erthink/libmdbx') ORDER BY created_at ASC LIMIT 100 offset 100
SELECT * FROM github_events WHERE event_type = 'IssuesEvent' and (repo_name = 'leo-yuriev/libmdbx' or repo_name = 'erthink/libmdbx') ORDER BY created_at ASC LIMIT 5
SELECT * FROM github_events WHERE event_type = 'IssuesEvent' and (repo_name = 'leo-yuriev/libmdbx' or repo_name = 'erthink/libmdbx') ORDER BY created_at DESC LIMIT 5
SELECT * FROM github_events WHERE file_time>='2022-01-01 00:00:00'
SELECT * FROM github_events WHERE file_time>='2022-11-01 00:00:00' LIMIT 10
SELECT * FROM github_events WHERE ilike(body, '%b201%') LIMIT 1000
SELECT * FROM github_events WHERE ilike(body, '%b201%') or ilike(body, '%b101%') or ilike(body, '%b301%') or ilike(body, '%b601%') LIMIT 1000
SELECT * FROM github_events WHERE ilike(body, '%b201%') or ilike(body, '%b202%') LIMIT 1000
SELECT * FROM github_events WHERE labels <>'[]' LIMIT 10
SELECT * FROM github_events WHERE repo_name = 'koppi/iso-country-flags-svg-collection'
SELECT * FROM github_events WHERE title = 'Currently version of MDBX is slower than original LMDB'
SELECT * FROM github_events WHERE title LIKE '%Currently version of MDBX is slower than original LMDB%'
SELECT * FROM hackernews LIMIT 10
SELECT * FROM hackernews WHERE deleted = 0
SELECT * FROM hackernews WHERE type = 'story'
SELECT * FROM hits LIMIT 10
SELECT * FROM hits LIMIT 100
SELECT * FROM hits LIMIT 1000000
SELECT * FROM hits LIMIT 3
SELECT * FROM hits WHERE EventDate = '2013-07-15' LIMIT 10
SELECT * FROM hits WHERE EventDate = '2013-07-15' and UserID = 15985305027620249815 LIMIT 100
SELECT * FROM hits WHERE EventDate = '2013-07-15' order by EventTime LIMIT 100
SELECT * FROM hits WHERE EventTime > '2000-07-15 19:26:13' order by EventTime desc LIMIT 10
SELECT * FROM hits WHERE EventTime > '2013-07-15 19:26:13'
SELECT * FROM hits WHERE GoodEvent not in (1,2)
SELECT * FROM hits WHERE UserID = 2981418249014407259
SELECT * FROM hits WHERE WatchID=4894690465724379622
SELECT * FROM hits_100m_compatible LIMIT 1
SELECT * FROM hits_100m_compatible LIMIT 100
SELECT * FROM hits_100m_compatible limit(10)
SELECT * FROM hits_100m_obfuscated
SELECT * FROM hits_100m_obfuscated WHERE locate(Title, 'xxx') < 10
SELECT * FROM hits_100m_obfuscated WHERE locate(Title, 'xxx') between 1 and 10
SELECT * FROM hits_100m_obfuscated WHERE match(Title, '([d]{3}[s-z]dAA[А-П]d{2}|[А-Я]{15,})')
SELECT * FROM hits_100m_obfuscated WHERE match(URL, '(d[a-f][f-z]0|thed{2,10})') and match(Title, '(d[a-f][f-z]0|thed{2,10}|ко)') and match(Title, '^Про')
SELECT * FROM hits_100m_obfuscated WHERE match(URL, '(d[a-f][f-z]0|thed{2,10})') and match(Title, '(d[a-f][f-z]0|thed{2,10}|ко)') and match(Title, '^Про') and CounterID > 70000
SELECT * FROM hits_100m_obfuscated WHERE match(URL, '(d[a-f][f-z]0|thed{2,10})') and match(Title, '(d[a-f][f-z]0|thed{2,10}|погода)')
SELECT * FROM hits_100m_obfuscated WHERE match(URL, '(fdjfjsf|dasfjsdofhids|dfsjfosfhsdf|fdsjofosdhfsd|fdsfoshf|913d20d|dasfjdiaf|fdsofsdhfusd|dfsjofosdvh|fdsnvsdbvo|fjsfowefh|fdnsonwdiofg|fdjsfdighowhg|fjsdofsufg|dfjsfoudsgb|fdsodsuf|fjdwfouw|PQJWEIE|FNDSFOIS|DNFOWF|FCJSDNFOWNEI|CNPSFNVWER|FPFQW|WPIEIFWEIGH|FWEOVBOW|FWEPIFWIG|FVNWEVNWEB|FPPWEJFHVI|F2OIEFOWUBV|FB2OEFBEO|FNDOIVIXC|QWOEJPJjIrie|fpdafjii3rh23|p1ndo1o3f|diqwedj2hi3h|difsdfidfid|dsosoxczooccoz|asjadaadaiaaa|saisaasasasas|sajsajsiajsiaijs|saisjoasiais|so1js1i2jsi2s|admin)') or match(Title, '(fdjfjsf|dasfjsdofhids|dfsjfosfhsdf|fdsjofosdhfsd|fdsfoshf|913d20d|dasfjdiaf|fdsofsdhfusd|dfsjofosdvh|fdsnvsdbvo|fjsfowefh|fdnsonwdiofg|fdjsfdighowhg|fjsdofsufg|dfjsfoudsgb|fdsodsuf|fjdwfouw|PQJWEIE|FNDSFOIS|DNFOWF|FCJSDNFOWNEI|CNPSFNVWER|FPFQW|WPIEIFWEIGH|FWEOVBOW|FWEPIFWIG|FVNWEVNWEB|FPPWEJFHVI|F2OIEFOWUBV|FB2OEFBEO|FNDOIVIXC|QWOEJPJjIrie|fpdafjii3rh23|p1ndo1o3f|diqwedj2hi3h|difsdfidfid|dsosoxczooccoz|asjadaadaiaaa|saisaasasasas|sajsajsiajsiaijs|saisjoasiais|so1js1i2jsi2s|admin)')
SELECT * FROM hits_100m_obfuscated WHERE match(URL, '(slo|va|de|rus)')
SELECT * FROM hits_100m_obfuscated WHERE match(URL, 'slova') LIMIT 10
SELECT * FROM hits_100m_obfuscated WHERE toDate(ClientEventTime)>'2013-07-01'
SELECT * FROM lineorder LIMIT 100
SELECT * FROM loc_stats
SELECT * FROM menu LIMIT 10,10
SELECT * FROM menu LIMIT 5000
SELECT * FROM menu WHERE sponsor= 'NORDDEUTSCHER LLOYD BREMEN'
SELECT * FROM menu WHERE sponsor= 'NORDDEUTSCHER LLOYD BREMEN' and event= 'LUNCH'
SELECT * FROM menu WHERE sponsor= 'NORDDEUTSCHER LLOYD BREMEN' and event= 'LUNCH' or event= 'DINNER'
SELECT * FROM menu_item
SELECT * FROM menu_item LIMIT 10
SELECT * FROM menu_item_denorm LIMIT 5000
SELECT * FROM ontime
SELECT * FROM ontime WHERE Year = 1987 LIMIT 5
SELECT * FROM opensky LIMIT 10
SELECT * FROM opensky WHERE registration = 'N811H' LIMIT 100
SELECT * FROM primes LIMIT 1
SELECT * FROM primes LIMIT 100
SELECT * FROM primes LIMIT 1000, 100
SELECT * FROM primes ORDER BY n DESC LIMIT 100
SELECT * FROM primes ORDER BY n LIMIT 100
SELECT * FROM query_metrics_v2
SELECT * FROM rdns
SELECT * FROM recipes LIMIT 1
SELECT * FROM recipes LIMIT 100
SELECT * FROM recipes LIMIT 50
SELECT * FROM recipes WHERE empty(NER)
SELECT * FROM recipes WHERE empty(NER) is not null
SELECT * FROM recipes WHERE has(NER, 'melon')
SELECT * FROM recipes WHERE has(NER,'melon')
SELECT * FROM recipes WHERE length(NER) >4
SELECT * FROM recipes WHERE title = 'Chocolate-Strawberry-Orange Wedding Cake'
SELECT * FROM recipes WHERE title LIKE 'P%'
SELECT * FROM reddit WHERE _edited is not null
SELECT * FROM reddit WHERE score = -673196
SELECT * FROM reddit WHERE score = 128026
SELECT * FROM repos
SELECT * FROM repos LIMIT 1
SELECT * FROM repos LIMIT 10
SELECT * FROM repos WHERE full_name != '' LIMIT 100
SELECT * FROM repos WHERE full_name is not null
SELECT * FROM repos WHERE full_name is not null or full_name != ''
SELECT * FROM repos WHERE full_name is not null or full_name != '' LIMIT 100
SELECT * FROM repos_raw
SELECT * FROM stock
SELECT * FROM stock LIMIT 1
SELECT * FROM stock LIMIT 10
SELECT * FROM trips
SELECT * FROM trips LIMIT 1
SELECT * FROM trips LIMIT 10
SELECT * FROM uk_price_paid LIMIT 10
SELECT * FROM uk_price_paid LIMIT 500
SELECT * FROM uk_price_paid WHERE postcode1 is not null --order by date desc LIMIT 10
SELECT * FROM uk_price_paid WHERE postcode1!='' --order by date desc LIMIT 10
SELECT * FROM uk_price_paid WHERE postcode1='W3' --order by date desc LIMIT 10
SELECT * FROM uk_price_paid WHERE postcode1='W3' and type='detached' --order by date desc LIMIT 10
SELECT * FROM uk_price_paid WHERE postcode1='W3' and type='detached' and duration='freehold' --order by date desc LIMIT 100
SELECT * FROM uk_price_paid WHERE postcode1='W3' and type='detached' and duration='freehold' order by date desc LIMIT 100
SELECT * FROM uk_price_paid order by date desc LIMIT 10
SELECT * FROM wikistat LIMIT 100
SELECT * FROM wikistat LIMIT 1000
SELECT * FROM wikistat LIMIT 10000000, 10
SELECT * From cell_towers
SELECT * From cell_towers WHERE lat BETWEEN '54' AND '56' AND lon BETWEEN '54' AND '56'
SELECT * From cell_towers Where radio ='GSM' AND lat > 66 AND created > 2020/06/01 ORDER BY area ASC
SELECT * From cell_towers Where radio ='GSM' AND lat > 66 AND created > 2020/06/01 ORDER BY samples DESC
SELECT * From cell_towers Where radio ='GSM' ORDER BY 'samples' ASC
SELECT * From cell_towers Where radio ='GSM' ORDER BY 'samples' DESC
SELECT * From cell_towers Where radio ='GSM' ORDER BY samples DESC
SELECT * From cell_towers Where radio ='UMTS'
SELECT * From cell_towers Where radio ='UMTS' Order by 'samples' DESC
SELECT *, ACOS(ABS(CounterID)) FROM hits LIMIT 100000
SELECT *, ACOS(CounterID) FROM hits LIMIT 100000
SELECT *, check_name, check_start_time FROM default.checks LIMIT 100
SELECT *, subreddit FROM reddit LIMIT 5
SELECT *, subreddit as lol FROM reddit LIMIT 5
SELECT *from opensky
SELECT 10 FROM recipes LIMIT 10
SELECT ACOS(ABS(CounterID)) FROM hits LIMIT 100000
SELECT ACOS(CounterID) FROM hits LIMIT 100000
SELECT AVG(samples) FROM cell_towers GROUP BY radio
SELECT AVG(samples), MAX(created), radio FROM cell_towers GROUP BY radio
SELECT AVG(samples), radio FROM cell_towers GROUP BY radio
SELECT AVG(samples), radio FROM cell_towers WHERE lat BETWEEN 54 AND 56 AND lon BETWEEN 54 AND 56 GROUP BY radio
SELECT AVG(score) FROM reddit
SELECT ArrTime, DepTime, Dest, Tail_Number FROM ontime WHERE DepTime < ArrTime AND Tail_Number != '' AND toYYYYMM(FlightDate) = toYYYYMM(toDate('2017-01-01')) ORDER BY Tail_Number, ArrTime LIMIT 10
SELECT CAST(toDateTime(toStartOfMonth(d)), 'INT') AS month, median(u) FROM (SELECT CAST(time, 'Date') AS d, uniq(author) AS u FROM git_clickhouse.commits GROUP BY d ORDER BY d ASC) GROUP BY month ORDER BY month ASC
SELECT CAST(toStartOfInterval(created_at, toIntervalDay(_CAST(7, 'UInt16'))), 'INT') AS t, count() AS events FROM github_events WHERE (repo_name = _CAST('ClickHouse/ClickHouse', 'String')) AND (created_at >= _CAST(18262, 'Date')) AND (event_type = 'IssueCommentEvent') AND (actor_login NOT LIKE 'robot-%') AND (actor_login NOT LIKE '%[bot]') GROUP BY t ORDER BY t ASC
SELECT CAST(toStartOfInterval(created_at, toIntervalDay(_CAST(7, 'UInt16'))), 'INT') AS t, count() AS events FROM github_events WHERE (repo_name = _CAST('ClickHouse/ClickHouse', 'String')) AND (created_at >= _CAST(18262, 'Date')) AND (event_type = 'PullRequestEvent') AND (action = 'opened') AND (actor_login NOT LIKE 'robot-%') AND (actor_login NOT LIKE '%[bot]') GROUP BY t ORDER BY t ASC
SELECT CAST(toStartOfInterval(created_at, toIntervalDay(_CAST(7, 'UInt16'))), 'INT') AS t, uniq(actor_login) AS authors FROM github_events WHERE (repo_name = _CAST('ClickHouse/ClickHouse', 'String')) AND (created_at >= _CAST(18262, 'Date')) AND (event_type = 'IssueCommentEvent') AND (actor_login NOT LIKE 'robot-%') AND (actor_login NOT LIKE '%[bot]') GROUP BY t ORDER BY t ASC
SELECT CAST(toStartOfInterval(created_at, toIntervalDay(_CAST(7, 'UInt16'))), 'INT') AS t, uniq(actor_login) AS authors FROM github_events WHERE (repo_name = _CAST('ClickHouse/ClickHouse', 'String')) AND (created_at >= _CAST(18262, 'Date')) AND (event_type = 'PullRequestEvent') AND (action = 'opened') AND (actor_login NOT LIKE 'robot-%') AND (actor_login NOT LIKE '%[bot]') GROUP BY t ORDER BY t ASC
SELECT CAST(toStartOfMonth(d), 'INT') AS month, median(u) FROM (SELECT CAST(time, 'Date') AS d, uniq(author) AS u FROM git_clickhouse.commits GROUP BY d ORDER BY d ASC) GROUP BY month ORDER BY month ASC
SELECT COUNT () FROM cell_towers
SELECT COUNT (*) FROM github_events WHERE event_type='FollowEvent'
SELECT COUNT (*) FROM github_events WHERE event_type='FollowEvent' and actor_login ='sergey-alekseev'
SELECT COUNT (radio) FROM cell_towers ORDER BY COUNT (radio) DESC
SELECT COUNT (radio) FROM cell_towers WHERE lon BETWEEN 54 AND 56 AND lat BETWEEN 54 AND 56 AND radio = 'GSM' ORDER BY COUNT (radio) DESC
SELECT COUNT (radio) FROM cell_towers WHERE lon BETWEEN 54 AND 56 AND lat BETWEEN 54 AND 56 GROUP BY radio ORDER BY COUNT (radio) DESC
SELECT COUNT (radio) FROM cell_towers WHERE lon BETWEEN 54 AND 56 AND lat BETWEEN 54 AND 56 ORDER BY COUNT (radio) DESC
SELECT COUNT() FROM cell_towers
SELECT COUNT() FROM recipes
SELECT COUNT() as sumCounts
SELECT COUNT(*) AS `COUNT(*)` FROM `default`.`github_events` LIMIT 50000
SELECT COUNT(*) FROM (SELECT * FROM git_clickhouse.commits c ) dbvrcnt
SELECT COUNT(*) FROM (SELECT DISTINCT c.author, COUNT(c.hash) OVER (PARTITION BY c.author) FROM git_clickhouse.commits c ) dbvrcnt
SELECT COUNT(*) FROM (SELECT DISTINCT c.author, COUNT(c.hash) OVER (PARTITION BY c.author) as `commit_count`, MIN(c.`time`) OVER (PARTITION BY c.author) as `first_commit` FROM git_clickhouse.commits c ) dbvrcnt
SELECT COUNT(*) FROM (SELECT DISTINCT c.author, COUNT(c.hash) OVER (PARTITION BY c.author) as `commit_count`, MIN(c.`time`) OVER (PARTITION BY c.author) as `first_commit`, MAX(c.`time`) OVER (PARTITION BY c.author) as `last_commit` FROM git_clickhouse.commits c ) dbvrcnt
SELECT COUNT(*) FROM (SELECT c.author, COUNT(c.hash) OVER (ORDER BY c.author) FROM git_clickhouse.commits c ) dbvrcnt
SELECT COUNT(*) FROM (SELECT c.author, COUNT(c.hash) as commit_count, MIN(c.`time`) as first_commit, max(c.`time`) as last_commit FROM git_clickhouse.commits c GROUP BY c.author ) dbvrcnt
SELECT COUNT(*) FROM `blogs`.`forex` LIMIT 1001
SELECT COUNT(*) FROM `default`.checks
SELECT COUNT(*) FROM `default`.covid
SELECT COUNT(*) FROM `default`.github_events
SELECT COUNT(*) FROM blogs.hackernews_json_v2 hjv WHERE hjv .`time` >'2021-07-18'
SELECT COUNT(*) FROM blogs.hackernews_json_v2 hjv WHERE hjv .`time` >'2021-07-19 00:00:00' and hjv.`time` <='2021-07-19 23:59:59'
SELECT COUNT(*) FROM blogs.noaa t
SELECT COUNT(*) FROM git_clickhouse.commits
SELECT COUNT(*) FROM git_clickhouse.commits t
SELECT COUNT(*) FROM uk_price_paid
SELECT COUNT(DISTINCT c.hash) as counts FROM git_clickhouse.commits c
SELECT COUNT(DISTINCT date) FROM (SELECT date, SUM(new_tested) FROM covid WHERE location_key = 'RU' GROUP BY date) AS ru JOIN (SELECT date, SUM(new_tested) FROM covid WHERE location_key = 'KZ' GROUP BY date) AS kz ON ru.date = kz.date
SELECT COUNT(IsMobile) FROM hits
SELECT COUNT(RegionID) FROM hits
SELECT COUNT(Title) FROM hits
SELECT COUNT(UserID) FROM hits
SELECT COUNT(WatchID) FROM hits
SELECT COUNT(cell) FROM cell_towers WHERE lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56
SELECT COUNT(cell) FROM cell_towers WHERE lat BETWEEN 54 AND 56 AND lon BETWEEN 54 AND 56 GROUP BY cell
SELECT COUNT(cell) FROM cell_towers WHERE lon >= 54 AND lon <= 56 AND lat >= 54 AND lat <= 56
SELECT COUNT(cell), cell FROM cell_towers WHERE lat BETWEEN 54 AND 56 AND lon BETWEEN 54 AND 56 GROUP BY cell
SELECT COUNT(origin) FROM opensky WHERE not empty(destination) and not empty(origin) GROUP by origin
SELECT COUNT(radio) FROM cell_towers WHERE lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56
SELECT COUNT(radio) FROM cell_towers WHERE lat BETWEEN 54 AND 56 AND lon BETWEEN 54 AND 56 GROUP BY radio
SELECT COUNT(radio) FROM cell_towers WHERE lon >= 54 AND lon <= 56 AND lat >= 54 AND lat <= 56 GROUP BY radio
SELECT COUNT(radio) FROM cell_towers WHERE radio = 'GSM'
SELECT COUNT(radio) FROM cell_towers WHERE radio = 'GSM' AND lon >= 54 AND lon <= 56 AND lat >= 54 AND lat <= 56
SELECT COUNT(radio), cell FROM cell_towers WHERE lat BETWEEN 54 AND 56 AND lon BETWEEN 54 AND 56 GROUP BY cell
SELECT COUNT(radio), cell FROM cell_towers WHERE lat BETWEEN 54 AND 56 AND lon BETWEEN 54 AND 56 GROUP BY cell ORDER BY COUNT(radio)
SELECT COUNT(radio), cell FROM cell_towers WHERE lat BETWEEN 54 AND 56 AND lon BETWEEN 54 AND 56 GROUP BY cell ORDER BY COUNT(radio) DESC
SELECT COUNT(radio), radio FROM cell_towers WHERE lat BETWEEN 54 AND 56 AND lon BETWEEN 54 AND 56 GROUP BY radio
SELECT Carrier, c, c2, c*100/c2 as c3 FROM ( SELECT IATA_CODE_Reporting_Airline AS Carrier, count(*) AS c FROM ontime GROUP BY Carrier ) q JOIN ( SELECT IATA_CODE_Reporting_Airline AS Carrier, count(*) AS c2 FROM ontime GROUP BY Carrier ) qq USING Carrier ORDER BY c3 DESC
SELECT Carrier, c, c2, c*100/c2 as c3 FROM ( SELECT IATA_CODE_Reporting_Airline AS Carrier, count(*) AS c FROM ontime WHERE DepDelay>10 AND Year=2007 GROUP BY Carrier ) q JOIN ( SELECT IATA_CODE_Reporting_Airline AS Carrier, count(*) AS c2 FROM ontime WHERE Year=2007 GROUP BY Carrier ) qq USING Carrier ORDER BY c3 DESC
SELECT Count(*) FROM covid
SELECT CounterID RegionID FROM hits GROUP BY CounterID
SELECT CounterID, cn FROM (SELECT CounterID,row_number() over (partition by CounterID) as rn, count(*) over (partition by CounterID) AS cn FROM hits) WHERE rn = 1 order by cn LIMIT 10
SELECT CounterID, cn FROM (SELECT CounterID,row_number() over (partition by CounterID) as rn, count(*) over (partition by CounterID) AS cn FROM hits) WHERE rn = 1 order by cn desc LIMIT 10
SELECT CounterID, max(RegionID) over (partition by CounterID) as maxRegionID FROM hits
SELECT CounterID,count(*) AS cn FROM hits GROUP by CounterID order by CounterID desc LIMIT 10
SELECT CounterID,count(*) AS cn FROM hits GROUP by CounterID order by cn desc LIMIT 10
SELECT CounterID,count(*) over (partition by CounterID) AS cn FROM hits order by CounterID desc LIMIT 10
SELECT DISTINCT (cell) FROM cell_towers WHERE lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56
SELECT DISTINCT (cell), COUNT (mcc) FROM cell_towers WHERE lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56 GROUP BY cell
SELECT DISTINCT (cell), COUNT (mcc) FROM cell_towers WHERE lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56 GROUP BY cell ORDER BY COUNT (mcc) DESC
SELECT DISTINCT * FROM blogs.countries
SELECT DISTINCT * FROM cell_towers WHERE lon >= 54 AND lon <= 56 AND lat >= 54 AND lat <= 56
SELECT DISTINCT * FROM cell_towers WHERE lon >= 54 AND lon <= 56 AND lat >= 54 AND lat <= 56 AND radio = 'GSM'
SELECT DISTINCT COUNT(cell) FROM cell_towers
SELECT DISTINCT COUNT(cell) FROM cell_towers WHERE lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56
SELECT DISTINCT MAX(cell) FROM cell_towers WHERE lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56
SELECT DISTINCT c.author, COUNT(c.hash) OVER (PARTITION BY c.author ) AS `commit_count` FROM git_clickhouse.commits c ORDER BY commit_count
SELECT DISTINCT c.author, COUNT(c.hash) OVER (PARTITION BY c.author ) AS `commit_count` FROM git_clickhouse.commits c ORDER BY commit_count DESC
SELECT DISTINCT c.author, COUNT(c.hash) OVER (PARTITION BY c.author ) AS `commit_count`, MIN(c.`time`) OVER (PARTITION BY c.author ) AS `first_commit`, MAX(c.`time`) OVER (PARTITION BY c.author ) AS `last_commit` FROM git_clickhouse.commits c ORDER BY commit_count
SELECT DISTINCT c.author, COUNT(c.hash) OVER (PARTITION BY c.author ) AS `commit_count`, MIN(c.`time`) OVER (PARTITION BY c.author ) AS `first_commit`, MAX(c.`time`) OVER (PARTITION BY c.author ) AS `last_commit` FROM git_clickhouse.commits c ORDER BY commit_count DESC
SELECT DISTINCT c.author, COUNT(c.hash) OVER (PARTITION BY c.author) FROM git_clickhouse.commits c
SELECT DISTINCT c.author, COUNT(c.hash) OVER (PARTITION BY c.author) as `commit_count` FROM git_clickhouse.commits c
SELECT DISTINCT c.author, COUNT(c.hash) OVER (PARTITION BY c.author) as `commit_count`, MIN(c.`time`) OVER (PARTITION BY c.author) as `first_commit` FROM git_clickhouse.commits c
SELECT DISTINCT c.author, COUNT(c.hash) OVER (PARTITION BY c.author) as `commit_count`, MIN(c.`time`) OVER (PARTITION BY c.author) as `first_commit`, MAX(c.`time`) OVER (PARTITION BY c.author) as `last_commit` FROM git_clickhouse.commits c
SELECT DISTINCT c.author, COUNT(c.hash) OVER (PARTITION BY c.author) as `commit_count`, MIN(c.`time`) OVER (PARTITION BY c.author) as `first_commit`, MAX(c.`time`) OVER (PARTITION BY c.author) as `last_commit` FROM git_clickhouse.commits c ORDER BY COUNT(c.hash) OVER (PARTITION BY c.author)
SELECT DISTINCT c.author, COUNT(c.hash) OVER (PARTITION BY c.author) as `commit_count`, MIN(c.`time`) OVER (PARTITION BY c.author) as `first_commit`, MAX(c.`time`) OVER (PARTITION BY c.author) as `last_commit` FROM git_clickhouse.commits c ORDER BY COUNT(c.hash) OVER (PARTITION BY c.author) DESC
SELECT DISTINCT cell FROM cell_towers WHERE lat BETWEEN '54' AND '56' AND lon BETWEEN '54' AND '56'
SELECT DISTINCT cell FROM cell_towers WHERE lat BETWEEN '54' AND '56' AND lon BETWEEN '54' AND '56' GROUP BY cell
SELECT DISTINCT cell, radio FROM cell_towers WHERE lat BETWEEN '54' AND '56' AND lon BETWEEN '54' AND '56'
SELECT DISTINCT count(name) FROM blogs.countries
SELECT DISTINCT count(name) as count FROM blogs.countries
SELECT DISTINCT name FROM blogs.countries
SELECT DISTINCT radio, COUNT(radio) FROM cell_towers WHERE lat BETWEEN '54' AND '56' AND lon BETWEEN '54' AND '56' Group by radio
SELECT DISTINCT radio, COUNT(radio) FROM cell_towers WHERE radio= 'GSM' AND lat BETWEEN '54' AND '56' AND lon BETWEEN '54' AND '56' Group by radio
SELECT DISTINCT radio, MAX (samples) FROM cell_towers Where created > 2017/01/01 AND radio='LTE' GROUP BY samples,radio
SELECT DISTINCT radio, MAX (samples) FROM cell_towers Where created > 2017/01/01 GROUP BY samples,radio
SELECT DISTINCT samples, radio, MAX (samples) FROM cell_towers Where created > 2017/01/01 AND radio='LTE' GROUP BY samples,radio
SELECT DISTINCT subreddit FROM `default`.reddit ORDER BY 1
SELECT DISTINCT subreddit_type FROM `default`.reddit ORDER BY 1
SELECT DISTINCT(cell),COUNT(radio) FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon > 54 AND lon < 56 AND lat > 54 GROUP BY cell
SELECT DISTINCT(cell),COUNT(radio) FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon > 54 AND lon < 56 AND lat > 54 GROUP BY cell ORDER BY COUNT(radio) ASC
SELECT DISTINCT(cell),COUNT(radio) FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon > 54 AND lon < 56 AND lat > 54 GROUP BY cell ORDER BY COUNT(radio) DESC
SELECT DISTINCT(cell),radio, COUNT(radio) FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon > 54 AND lon < 56 AND lat > 54 GROUP BY cell,radio
SELECT DISTINCT(cell),radio, SUM(radio) FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon > 54 AND lon < 56 AND lat > 54 GROUP BY cell,radio
SELECT DISTINCT(changed_files) FROM github_events WHERE file_time>='2022-11-01 00:00:00'
SELECT DISTINCT(pickup_date) FROM trips
SELECT DayOfWeek, count(*) AS c FROM ontime WHERE DepDelay>10 AND Year>=2000 AND Year<=2008 GROUP BY DayOfWeek ORDER BY c DESC
SELECT DayOfWeek, count(*) AS c FROM ontime WHERE DepDelay>10 GROUP BY DayOfWeek ORDER BY c DESC
SELECT DayOfWeek, count(*) AS c FROM ontime WHERE Year>=2000 AND Year<=2008 GROUP BY DayOfWeek ORDER BY DayOfWeek ASC
SELECT DayOfWeek, count(*) AS c FROM ontime WHERE Year>=2000 AND Year<=2008 GROUP BY DayOfWeek ORDER BY DayOfWeek DESC
SELECT DayOfWeek, count(*) AS c FROM ontime WHERE Year>=2000 AND Year<=2008 GROUP BY DayOfWeek ORDER BY c DESC
SELECT DayOfWeek, count(*) AS c FROM ontime WHERE Year>=2000 AND Year<=2008 and DepDelay>10 GROUP BY DayOfWeek ORDER BY c DESC
SELECT DestCityName, uniqExact(OriginCityName) AS u FROM ontime WHERE Year>=2000 and Year<=2010 GROUP BY DestCityName ORDER BY u DESC LIMIT 10
SELECT Distinct origin, COUNT(origin) FROM opensky WHERE NOT empty(origin) GROUP BY origin ORDER BY COUNT(origin) DESC
SELECT Distinct origin, COUNT(origin) cnt FROM opensky WHERE not empty(origin) GROUP by origin Order by cnt DESC
SELECT FlightDate, IATA_CODE_Reporting_Airline, Tail_Number, arraySort(groupArray(ArrTime)) AS Arrivals, arraySort((x, y) -> y, groupArray(Dest), groupArray(ArrTime)) AS Dests, arrayFilter((arr, dest) -> (dest in ('MDW', 'ORD')), Arrivals, Dests)[1] as CHI_Arr, length(Arrivals) as Hops FROM ontime WHERE DepTime < ArrTime AND Tail_Number != '' AND toYYYYMM(FlightDate) = toYYYYMM(toDate('2017-01-01')) GROUP BY FlightDate, IATA_CODE_Reporting_Airline, Tail_Number HAVING CHI_Arr > 0 ORDER BY FlightDate, IATA_CODE_Reporting_Airline, Tail_Number LIMIT 5
SELECT FlightDate, IATA_CODE_Reporting_Airline, Tail_Number, arraySort(groupArray(ArrTime)) AS Arrivals, arraySort((x, y) -> y, groupArray(Dest), groupArray(ArrTime)) AS Dests, arrayFilter((arr, dest) -> (dest in ('MDW', 'ORD')), Arrivals, Dests)[1] as CHI_Arr, length(Arrivals) as Hops FROM ontime WHERE DepTime < ArrTime AND Tail_Number != '' AND toYYYYMM(FlightDate) = toYYYYMM(toDate('2017-01-01')) GROUP BY FlightDate, IATA_CODE_Reporting_Airline, Tail_Number ORDER BY FlightDate, IATA_CODE_Reporting_Airline, Tail_Number LIMIT 5
SELECT FlightDate, IATA_CODE_Reporting_Airline, Tail_Number, windowFunnel(86400)(toUInt32(ArrTime), Dest IN ('MDW', 'ORD'), Dest = 'ATL') AS funnel_level FROM ontime WHERE DepTime < ArrTime AND Tail_Number != '' GROUP BY FlightDate, IATA_CODE_Reporting_Airline, Tail_Number ORDER BY FlightDate ASC, IATA_CODE_Reporting_Airline ASC, Tail_Number ASC
SELECT GoodEvent FROM (SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID) as a inner join hits_100m_compatible on hits_100m_compatible.CounterID = a.CounterID and hits_100m_compatible.RegionID = a.maxRegionID order by GoodEvent limit(10)
SELECT LO_SHIPMODE , sum(LO_QUANTITY ) FROM lineorder WHERE LO_SHIPPRIORITY = 0 and LO_QUANTITY > 100 and LO_QUANTITY - LO_DISCOUNT > 0 GROUP by LO_SHIPMODE LIMIT 100
SELECT LocalEventTime FROM hits WHERE UserID = 9099549948362617742
SELECT LocalEventTime FROM hits WHERE UserID = 9099549948362617742 ORDER BY LocalEventTime
SELECT MAX(COUNT(cell)) FROM cell_towers WHERE lat BETWEEN 54 AND 56 AND lon BETWEEN 54 AND 56 GROUP BY cell
SELECT MAX(created), radio FROM cell_towers GROUP BY radio
SELECT MAX(created), radio FROM cell_towers GROUP BY radio ORDER BY MAX(created) DESC
SELECT MAX(created), radio FROM cell_towers WHERE lat BETWEEN 54 AND 56 AND lon BETWEEN 54 AND 56 GROUP BY radio ORDER BY MAX(created) DESC
SELECT MAX(samples) FROM cell_towers WHERE created > 2017-01-01 GROUP BY radio
SELECT MIN(created) FROM cell_towers WHERE lat BETWEEN 54 AND 56 AND lon BETWEEN 54 AND 56 ORDER BY MIN(created) ASC
SELECT MIN(created), radio FROM cell_towers GROUP BY radio
SELECT MIN(created), radio FROM cell_towers GROUP BY radio ORDER BY MIN(created) ASC
SELECT MIN(created), radio FROM cell_towers WHERE lat BETWEEN 54 AND 56 AND lon BETWEEN 54 AND 56 GROUP BY radio
SELECT MIN(created), radio FROM cell_towers WHERE lat BETWEEN 54 AND 56 AND lon BETWEEN 54 AND 56 GROUP BY radio ORDER BY MIN(created) ASC
SELECT MIN(timestamp) FROM dns
SELECT MIN(timestamp), MAX(timestamp) FROM dns
SELECT Max (samples) From cell_towers
SELECT NER FROM recipes LIMIT 10
SELECT OriginCityName, count() AS c FROM ontime GROUP BY OriginCityName ORDER BY c DESC LIMIT 10
SELECT RegionID , OS, sum(JavaEnable), count() FROM hits_100m_compatible WHERE RegionID = 839 GROUP by RegionID , OS
SELECT RegionID , OS, sum(JavaEnable), count() FROM hits_100m_compatible WHERE RegionID = 839 GROUP by RegionID , OS with cube
SELECT RegionID , OS, sum(JavaEnable), count() FROM hits_100m_compatible WHERE RegionID = 839 GROUP by RegionID , OS with rollup
SELECT RegionID , OS, sum(JavaEnable), count() FROM hits_100m_compatible WHERE RegionID = 839 GROUP by RegionID , OS with totals
SELECT RegionID , OS, sum(NetMajor), count() FROM hits_100m_compatible WHERE NetMajor = 26449 GROUP by RegionID , OS
SELECT RegionID , OS, sum(NetMajor), count() FROM hits_100m_compatible WHERE OS = 44 GROUP by RegionID , OS
SELECT RegionID , OS, sum(NetMajor), count() FROM hits_100m_compatible WHERE RegionID = 26449 GROUP by RegionID , OS
SELECT SUM("IsNotBounce") AS "IsNotBounce", "BrowserCountry" AS "BrowserCountry", SUM("CookieEnable") AS "CookieEnable", SUM("IsNotBounce") AS "IsNotBounce", "BrowserCountry" AS "BrowserCountry", SUM("CookieEnable") AS "CookieEnable" FROM "default"."hits" GROUP BY "BrowserCountry", "BrowserCountry"
SELECT Time as DateTime, count() FROM github_events WHERE (repo_name = 'grafana/grafana') AND(event_type = 'PullRequestEvent') AND(Time >= 1666618231) AND(Time <= 1669213831) GROUP BY toStartOfDay(created_at) AS Time ORDER BY Time ASC
SELECT Time as DateTime, count() FROM github_events WHERE (repo_name = 'grafana/grafana') AND(event_type = 'PullRequestEvent') GROUP BY toStartOfDay(created_at) AS Time ORDER BY Time ASC
SELECT ToP 10 * FROM menu_item_denorm
SELECT UserID FROM hits GROUP BY UserID HAVING UserID = '8585742290196126178'
SELECT UserID FROM hits LIMIT 10
SELECT UserID, LocalEventTime - any(LocalEventTime) OVER (ORDER BY LocalEventTime ASC Rows BETWEEN 1 PRECEDING AND 1 PRECEDING) AS diff FROM hits
SELECT UserID, LocalEventTime - any(LocalEventTime) OVER (ORDER BY LocalEventTime ASC Rows BETWEEN 1 PRECEDING AND 1 PRECEDING) AS frame_values FROM hits WHERE UserID = 2855564236250770534
SELECT UserID, LocalEventTime FROM hits LIMIT 10
SELECT UserID, LocalEventTime, LocalEventTime - any(LocalEventTime) OVER (ORDER BY LocalEventTime ASC Rows BETWEEN 1 PRECEDING AND 1 PRECEDING) AS frame_values FROM hits WHERE UserID = 2855564236250770534
SELECT UserID, LocalEventTime, any(LocalEventTime) OVER (ORDER BY LocalEventTime ASC Rows BETWEEN 1 PRECEDING AND 1 PRECEDING) AS frame_values FROM hits WHERE UserID = 2855564236250770534
SELECT UserID, LocalEventTime, groupArray(LocalEventTime) OVER (ORDER BY LocalEventTime ASC Rows BETWEEN 1 PRECEDING AND 1 PRECEDING) AS frame_values FROM hits WHERE UserID = 2855564236250770534
SELECT UserID, LocalEventTime, groupArray(LocalEventTime) OVER (ORDER BY LocalEventTime ASC Rows BETWEEN 1 PRECEDING AND CURRENT ROW) AS frame_values FROM hits
SELECT UserID, LocalEventTime, groupArray(LocalEventTime) OVER (ORDER BY LocalEventTime ASC Rows BETWEEN 1 PRECEDING AND CURRENT ROW) AS frame_values FROM hits WHERE UserID = 2855564236250770534
SELECT UserID, OS, sum(NetMajor), count() FROM hits_100m_compatible GROUP by UserID, OS
SELECT UserID, OS, sum(NetMajor), count() FROM hits_100m_compatible WHERE OS = 44 GROUP by UserID, OS
SELECT UserID, count(1) FROM ( SELECT UserID, LocalEventTime - any(LocalEventTime) OVER (ORDER BY LocalEventTime ASC Rows BETWEEN 1 PRECEDING AND 1 PRECEDING) AS diff FROM hits WHERE UserID = 2855564236250770534 OR UserID = 9099549948362617742 ) as sq GROUP by UserID
SELECT UserID, count(1) FROM ( SELECT UserID, LocalEventTime - any(LocalEventTime) OVER (ORDER BY LocalEventTime ASC Rows BETWEEN 1 PRECEDING AND 1 PRECEDING) AS diff FROM hits WHERE UserID = 2855564236250770534 OR UserID = 9099549948362617742 ) as sq WHERE diff > 30 GROUP by UserID
SELECT UserID, count(1) FROM ( SELECT UserID, LocalEventTime - any(LocalEventTime) OVER (ORDER BY LocalEventTime ASC Rows BETWEEN 1 PRECEDING AND 1 PRECEDING) AS frame_values FROM hits WHERE UserID = 2855564236250770534 ) as sq GROUP by UserID
SELECT UserID, count(1) FROM ( SELECT UserID, LocalEventTime - any(LocalEventTime) OVER (ORDER BY LocalEventTime ASC Rows BETWEEN 1 PRECEDING AND 1 PRECEDING) AS frame_values FROM hits WHERE UserID = 2855564236250770534 OR UserID = 9099549948362617742 ) as sq GROUP by UserID
SELECT UserID, count(1) FROM ( SELECT UserID, LocalEventTime - any(LocalEventTime) OVER (PARTITION BY UserID ORDER BY LocalEventTime ASC Rows BETWEEN 1 PRECEDING AND 1 PRECEDING) AS diff FROM hits WHERE UserID = 2855564236250770534 OR UserID = 9099549948362617742 ) as sq WHERE diff > 30 GROUP by UserID
SELECT UserID, count(1) FROM hits GROUP by UserID
SELECT UserID, count(1) FROM hits WHERE UserID % 100 = 34 GROUP by UserID
SELECT UserID, groupArray(1)(ClientIP) FROM (SELECT UserID,UserAgent,ClientIP,COUNT(*) as cn FROM hits GROUP by UserID,UserAgent,ClientIP ) WHERE UserID = '277532775695' GROUP by UserID
SELECT UserID, groupArray(1)(ClientIP) FROM (SELECT UserID,UserAgent,ClientIP,COUNT(*) as cn FROM hits GROUP by UserID,UserAgent,ClientIP order by UserID,ClientIP,cn desc ) GROUP by UserID
SELECT UserID, groupArray(1)(ClientIP) FROM (SELECT UserID,UserAgent,ClientIP,COUNT(*) as cn FROM hits GROUP by UserID,UserAgent,ClientIP order by UserID,cn desc ) GROUP by UserID
SELECT UserID, groupArray(1)(ClientIP) FROM (SELECT UserID,UserAgent,ClientIP,COUNT(*) as cn FROM hits GROUP by UserID,UserAgent,ClientIP order by UserID,cn desc ) WHERE UserID = '277532775695' GROUP by UserID
SELECT UserID, groupArray(1)(URL) FROM (SELECT UserID,UserAgent,URL,COUNT(*) as cn FROM hits GROUP by UserID,UserAgent,URL ) GROUP by UserID
SELECT UserID, groupArray(1)(URL) FROM (SELECT UserID,UserAgent,URL,COUNT(*) as cn FROM hits GROUP by UserID,UserAgent,URL order by UserID,URL,cn desc ) GROUP by UserID
SELECT UserID,UserAgent,COUNT(*) as cn FROM hits GROUP by UserID,UserAgent
SELECT UserID,UserAgent,ClientIP,COUNT(*) as cn FROM hits GROUP by UserID,UserAgent,ClientIP
SELECT UserID,UserAgent,ClientIP,COUNT(*) as cn FROM hits GROUP by UserID,UserAgent,ClientIP order by UserID,ClientIP,cn desc
SELECT UserID,UserAgent,ClientIP,COUNT(*) as cn FROM hits GROUP by UserID,UserAgent,ClientIP order by UserID,cn desc
SELECT UserID,UserAgent,ClientIP,COUNT(*) as cn FROM hits GROUP by UserID,UserAgent,ClientIP order by cn desc
SELECT UserID,UserAgent,URL FROM hits
SELECT UserID,UserAgent,URL,COUNT(*) as cn FROM hits GROUP by UserID,UserAgent,URL
SELECT UserID,UserAgent,URL,COUNT(*) as cn FROM hits GROUP by UserID,UserAgent,URL order by UserID,URL,cn desc
SELECT UserID,UserAgent,arrayJoin(groupArray(1)(ClientIP)) FROM ( SELECT UserID,UserAgent,ClientIP,CounterID,count(*) as cn FROM hits WHERE UserID = 2981418249014407259 GROUP by UserID,UserAgent,ClientIP,CounterID order by UserID,UserAgent,cn desc ) GROUP by UserID,UserAgent
SELECT UserID,UserAgent,groupArray(1)(ClientIP) FROM ( SELECT UserID,UserAgent,ClientIP,CounterID,count(*) as cn FROM hits GROUP by UserID,UserAgent,ClientIP,CounterID order by UserID,UserAgent,cn desc ) GROUP by UserID,UserAgent
SELECT UserID,UserAgent,groupArray(1)(ClientIP) FROM ( SELECT UserID,UserAgent,ClientIP,CounterID,count(*) as cn FROM hits WHERE UserID = 2981418249014407259 GROUP by UserID,UserAgent,ClientIP,CounterID order by UserID,UserAgent,cn desc ) GROUP by UserID,UserAgent
SELECT UserID,UserAgent,toString(groupArray(1)(ClientIP)) FROM ( SELECT UserID,UserAgent,ClientIP,CounterID,count(*) as cn FROM hits WHERE UserID = 2981418249014407259 GROUP by UserID,UserAgent,ClientIP,CounterID order by UserID,UserAgent,cn desc ) GROUP by UserID,UserAgent
SELECT WatchID FROM (SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID) as a inner join hits_100m_compatible on hits_100m_compatible.CounterID = a.CounterID
SELECT WatchID FROM (SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID) as a inner join hits_100m_compatible on hits_100m_compatible.CounterID = a.CounterID and hits_100m_compatible.RegionID = a.maxRegionID
SELECT WatchID FROM (SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID) as a inner join hits_100m_compatible on hits_100m_compatible.CounterID = a.CounterID and hits_100m_compatible.RegionID = a.maxRegionID limit(10)
SELECT WatchID FROM (SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID) as a inner join hits_100m_compatible on hits_100m_compatible.CounterID = a.CounterID and hits_100m_compatible.RegionID = a.maxRegionID order by WatchID limit(10)
SELECT WatchID FROM hits GROUP by WatchID order by WatchID
SELECT WatchID FROM hits GROUP by WatchID order by WatchID UNION ALL SELECT WatchID FROM hits GROUP by WatchID order by WatchID
SELECT WatchID FROM hits WHERE EventTime > '2010-07-15 19:26:13' order by EventTime desc LIMIT 10
SELECT WatchID FROM hits WHERE WatchID = 4611686071420045196 GROUP by WatchID order by WatchID
SELECT WatchID FROM hits WHERE WatchID = 4611686071420045196 GROUP by WatchID order by WatchID UNION ALL SELECT WatchID FROM hits WHERE WatchID = 4611686071420045196
SELECT WatchID FROM hits WHERE WatchID = 4611686071420045196 GROUP by WatchID order by WatchID UNION ALL SELECT WatchID FROM hits WHERE WatchID = 4611686071420045196 GROUP by WatchID order by WatchID
SELECT WatchID as test FROM hits WHERE WatchID = 4611686071420045196 GROUP by test order by test
SELECT WatchID as watch FROM hits LIMIT 10
SELECT WatchID, EventTime, EventDate, UserID, rank() over (partition by UserID order by EventTime) r FROM hits WHERE EventDate = '2013-07-15' and UserID = 15985305027620249815 LIMIT 100
SELECT WatchID,JavaEnable,Title,GoodEvent,EventTime AS EventTime ,EventDate,CounterID,ClientIP FROM hits WHERE EventTime > '2010-07-15 19:26:13' order by EventTime desc LIMIT 10
SELECT WatchID,JavaEnable,Title,GoodEvent,EventTime AS EventTime1 ,EventDate,CounterID,ClientIP FROM hits WHERE EventTime > '2010-07-15 19:26:13' order by EventTime desc LIMIT 10
SELECT WatchID,JavaEnable,Title,GoodEvent,EventTime,EventDate,CounterID,ClientIP FROM hits WHERE EventTime > '2010-07-15 19:26:13' order by EventTime desc LIMIT 10
SELECT WatchID,Title,GoodEvent,EventTime,EventDate,CounterID,ClientIP,RegionID FROM hits WHERE WatchID=4894690465724379622
SELECT WatchID,Title,GoodEvent,EventTime,EventDate,CounterID,ClientIP,RegionID,URL,UserAgentMajor,UserAgentMinor FROM hits WHERE WatchID=4894690465724379622
SELECT WatchID,count(*) AS cn FROM hits GROUP by WatchID LIMIT 10
SELECT WatchID,count(*) AS cn FROM hits GROUP by WatchID order by WatchID desc LIMIT 10
SELECT WatchID,count(*) over (partition by WatchID) AS cn FROM hits LIMIT 10
SELECT WatchID,count(*) over (partition by WatchID) AS cn FROM hits order by WatchID desc LIMIT 10
SELECT ['author','body'] FROM reddit
SELECT `NER_lower`, `count`, `percent` FROM ( SELECT `NER_lower`, `count`, `percent` FROM ( SELECT `NER_lower`, `count`, `percent` FROM ( SELECT t3.`NER_lower`, t3.`count`, t3.`percent` FROM ( SELECT * FROM ( SELECT *, (`count` * 100) / sum(`count`) OVER (ORDER BY Null) AS `percent` FROM ( SELECT lower(`NER`) AS `NER_lower`, count(lower(`NER`)) AS `count` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, `NER`, lower(`NER`) AS `NER_lower` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, arrayJoin(`NER`) AS `NER` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, `NER` FROM default.`recipes` ) t9 ) t8 ) t7 GROUP BY `NER_lower` ) t6 ) t5 ORDER BY `count` DESC ) t3 WHERE match(t3.`NER_lower`, 'salt') ) t2 ) t1 ) t0
SELECT `NER_lower`, `count`, `percent` FROM ( SELECT `NER_lower`, `count`, `percent` FROM ( SELECT t2.`NER_lower`, t2.`count`, t2.`percent` FROM ( SELECT * FROM ( SELECT *, (`count` * 100) / sum(`count`) OVER (ORDER BY Null) AS `percent` FROM ( SELECT lower(`NER`) AS `NER_lower`, count(lower(`NER`)) AS `count` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, `NER`, lower(`NER`) AS `NER_lower` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, arrayJoin(`NER`) AS `NER` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, `NER` FROM default.`recipes` ) t8 ) t7 ) t6 GROUP BY `NER_lower` ) t5 ) t4 ORDER BY `count` DESC ) t2 WHERE match(t2.`NER_lower`, 'salt') ) t1 ) t0 LIMIT 500
SELECT `NER_lower`, `count`, `percent` FROM ( SELECT t1.`NER_lower`, t1.`count`, t1.`percent` FROM ( SELECT * FROM ( SELECT *, (`count` * 100) / sum(`count`) OVER (ORDER BY Null) AS `percent` FROM ( SELECT lower(`NER`) AS `NER_lower`, count(lower(`NER`)) AS `count` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, `NER`, lower(`NER`) AS `NER_lower` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, arrayJoin(`NER`) AS `NER` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, `NER` FROM default.`recipes` ) t7 ) t6 ) t5 GROUP BY `NER_lower` ) t4 ) t3 ORDER BY `count` DESC ) t1 WHERE match(t1.`NER_lower`, 'salt') ) t0 LIMIT 10000
SELECT `commits` AS `commits` FROM `default`.`github_events` GROUP BY `commits` LIMIT 1000
SELECT `date`, `count` FROM (SELECT toStartOfMonth(created_at) as date, SUM (commits) as count FROM `default`.`github_events` GROUP by date order by date) AS `virtual_table` LIMIT 1000
SELECT `date`, `count` FROM (SELECT toStartOfMonth(created_at) as date, count() as count FROM github_events WHERE date < toStartOfMonth(now()) GROUP by date order by date) AS `virtual_table` LIMIT 1000
SELECT `event_type` AS `event_type`, COUNT(*) AS `count` FROM `default`.`github_events` GROUP BY `event_type` ORDER BY `count` DESC LIMIT 100
SELECT `file_time` AS `file_time`, `event_type` AS `event_type`, `actor_login` AS `actor_login`, `repo_name` AS `repo_name`, `created_at` AS `created_at`, `updated_at` AS `updated_at`, `action` AS `action`, `comment_id` AS `comment_id`, `body` AS `body`, `path` AS `path`, `position` AS `position`, `line` AS `line`, `ref` AS `ref`, `ref_type` AS `ref_type`, `creator_user_login` AS `creator_user_login`, `number` AS `number`, `title` AS `title`, `labels` AS `labels`, `state` AS `state`, `locked` AS `locked`, `assignee` AS `assignee`, `assignees` AS `assignees`, `comments` AS `comments`, `author_association` AS `author_association`, `closed_at` AS `closed_at`, `merged_at` AS `merged_at`, `merge_commit_sha` AS `merge_commit_sha`, `requested_reviewers` AS `requested_reviewers`, `requested_teams` AS `requested_teams`, `head_ref` AS `head_ref`, `head_sha` AS `head_sha`, `base_ref` AS `base_ref`, `base_sha` AS `base_sha`, `merged` AS `merged`, `mergeable` AS `mergeable`, `rebaseable` AS `rebaseable`, `mergeable_state` AS `mergeable_state`, `merged_by` AS `merged_by`, `review_comments` AS `review_comments`, `maintainer_can_modify` AS `maintainer_can_modify`, `commits` AS `commits`, `additions` AS `additions`, `deletions` AS `deletions`, `changed_files` AS `changed_files`, `diff_hunk` AS `diff_hunk`, `original_position` AS `original_position`, `commit_id` AS `commit_id`, `original_commit_id` AS `original_commit_id`, `push_size` AS `push_size`, `push_distinct_size` AS `push_distinct_size`, `member_login` AS `member_login`, `release_tag_name` AS `release_tag_name`, `release_name` AS `release_name`, `review_state` AS `review_state` FROM `default`.`github_events` LIMIT 1000
SELECT `file_time`, `event_type`, `actor_login`, `repo_name`, `created_at`, `updated_at`, `action`, `comment_id`, `body`, `path`, `position`, `line`, `ref`, `ref_type`, `creator_user_login`, `number`, `title`, `labels`, `state`, `locked`, `assignee`, `assignees`, `comments`, `author_association`, `closed_at`, `merged_at`, `merge_commit_sha`, `requested_reviewers`, `requested_teams`, `head_ref`, `head_sha`, `base_ref`, `base_sha`, `merged`, `mergeable`, `rebaseable`, `mergeable_state`, `merged_by`, `review_comments`, `maintainer_can_modify`, `commits`, `additions`, `deletions`, `changed_files`, `diff_hunk`, `original_position`, `commit_id`, `original_commit_id`, `push_size`, `push_distinct_size`, `member_login`, `release_tag_name`, `release_name`, `review_state` FROM `default`.`github_events` LIMIT 101
SELECT `kz.date` as date FROM (SELECT * FROM (SELECT date, SUM(new_tested) as new_tested FROM covid WHERE location_key = 'RU' GROUP BY date) AS ru INNER JOIN (SELECT date, SUM(new_tested) as new_tested FROM covid WHERE location_key = 'KZ' GROUP BY date) AS kz ON ru.date = kz.date )
SELECT `kz.date` as date FROM (SELECT * FROM (SELECT date, new_tested as new_tested FROM covid WHERE location_key = 'RU') AS ru INNER JOIN (SELECT date, new_tested as new_tested FROM covid WHERE location_key = 'KZ') AS kz ON ru.date = kz.date )
SELECT `kz.sum(new_tested)` FROM (SELECT date, SUM(new_tested) FROM covid WHERE location_key = 'RU' GROUP BY date) AS ru JOIN (SELECT date, SUM(new_tested) FROM covid WHERE location_key = 'KZ' GROUP BY date) AS kz ON ru.date = kz.date
SELECT `title`, `ingredients`, `directions`, `link`, `source`, arrayJoin(`NER`) AS `NER` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, `NER` FROM default.`recipes` ) t0 LIMIT 500
SELECT a.* FROM hits a WHERE a.UserID in (SELECT UserID FROM hits_100m_compatible LIMIT 100)
SELECT a.* FROM hits a join (SELECT * FROM hits_100m_compatible LIMIT 100)b on a.UserID = cast(b.UserID as UInt64)
SELECT a.* FROM hits a left join (SELECT * FROM hits_100m_compatible LIMIT 100)b on a.UserID = cast(b.UserID as UInt64)
SELECT a.UserID, a.URL, b.UserID FROM hits AS a LEFT JOIN ( SELECT UserID, UserID as HaHa FROM hits as c) AS b USING (UserID) LIMIT 3
SELECT action, count() FROM github_events WHERE event_type = 'WatchEvent' GROUP BY action
SELECT actor_login AS actorLogin, t AS activeMonth, c AS activityCount, n AS activityRank FROM ( SELECT actor_login, toStartOfMonth(created_at) AS t, COUNT(*) AS c, row_number() OVER (PARTITION BY t ORDER BY c DESC) AS n FROM github_events WHERE startsWith(repo_name, 'apache/pulsar') AND actor_login <> 'github-actions[bot]' AND t = '2017-06-01' GROUP BY t, actor_login ORDER BY t, n LIMIT 5 BY t )
SELECT actor_login AS actorLogin, t AS activeMonth, c AS activityCount, n AS activityRank FROM ( SELECT actor_login, toStartOfMonth(created_at) AS t, COUNT(*) AS c, row_number() OVER (PARTITION BY t ORDER BY c DESC) AS n FROM github_events WHERE startsWith(repo_name, 'apache/pulsar') AND actor_login <> 'github-actions[bot]' GROUP BY t, actor_login ORDER BY t, n LIMIT 5 BY t )
SELECT actor_login, count() AS c FROM github_events WHERE repo_name = 'ClickHouse/ClickHouse' AND actor_login NOT LIKE '%[bot]%' AND actor_login NOT LIKE '%robot-%' AND event_type = 'PullRequestEvent' AND created_at >= '2022-01-01' AND action = 'opened' GROUP BY actor_login ORDER BY c DESC
SELECT actor_login, count() AS c, c >= dateDiff('week', '2022-01-10'::Date, today()) * 4 AS ok FROM default.github_events WHERE created_at >= '2022-01-01' AND repo_name = 'ClickHouse/ClickHouse' AND event_type = 'PullRequestEvent' AND action = 'closed' AND actor_login = assignee GROUP BY actor_login ORDER BY c DESC
SELECT actor_login, count() AS c, uniq(repo_name) AS repos FROM github_events WHERE event_type = 'PushEvent' GROUP BY actor_login ORDER BY c DESC LIMIT 50
SELECT actor_login, count() AS stars FROM github_events WHERE event_type = 'WatchEvent' GROUP BY actor_login ORDER BY stars DESC LIMIT 50
SELECT actor_login, created_at, (event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, (event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type in (10, 11, 19, 6) AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, CAST(event_type, 'CHAR'), toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND match( event_type, 'PullRequestReviewEvent') AND actor_login NOT IN ('github-actions[bot]', 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, event_type AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type in (10, 11, 19, 6) AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type in (10, 11, 19, 6) AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, event_type, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND match( event_type, 'PullRequestReviewEvent') AND actor_login NOT IN ('github-actions[bot]', 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, hex(event_type), toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type = 'PullRequestReviewEvent' AND actor_login NOT IN ('github-actions[bot]', 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, hex(event_type), toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type in( 'PullRequestReviewEvent') AND actor_login NOT IN ('github-actions[bot]', 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, hex(event_type), toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND match( event_type, 'PullRequestReviewEvent') AND actor_login NOT IN ('github-actions[bot]', 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, length(event_type), toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND match( event_type, 'PullRequestReviewEvent') AND actor_login NOT IN ('github-actions[bot]', 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toLowCardinality(event_type), toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND match( event_type, 'PullRequestReviewEvent') AND actor_login NOT IN ('github-actions[bot]', 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toLowCardinality(event_type), toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND toString(event_type) = 'PullRequestReviewEvent' AND actor_login NOT IN ('github-actions[bot]', 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(action) AS action, number, merged_at, toString(event_type) as eventType FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(action) AS action, number, merged_at, toString(event_type) as event_type FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events PREWHERE number=9276 WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events PREWHERE number>0 WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events PREWHERE true WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events PREWHERE true WHERE repo_name = 'apache/pulsar' AND multiMatchAny(event_type, ['PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent']) AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND actor_login NOT IN ('github-actions[bot]', 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type = 'IssueCommentEvent' AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type = 'IssueCommentEvent' AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276 order by actor_login
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type = 'IssueCommentEvent' AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276 order by actor_login desc
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type = 'IssueCommentEvent' AND number = 9276
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND actor_login != 'hangc0276' AND number = 9276
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND actor_login = 'hangc0276' AND number = 9276
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276 settings query_plan_optimize_primary_key = 1
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND true AND number = 9276
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type in (10, 11, 19, 6) AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type like '%PullRequestReviewEvent%' AND actor_login NOT IN ('github-actions[bot]', 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND match( event_type, 'PullRequestReviewEvent') AND actor_login NOT IN ('github-actions[bot]', 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND multiMatchAny(event_type, ['PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent']) AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND multiMatchAny(event_type, ['PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent']) AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type) as eventType, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type) as event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type) as event_type1, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type) as event_typex, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toString(event_type), toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND event_type IN ('PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent') AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, created_at, toTypeName(event_type) AS event_type, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND multiMatchAny(event_type, ['PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent']) AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT actor_login, event_type, count( actor_login) as actions FROM github_events WHERE repo_name = 'faker-js/faker' AND created_at >= '2022-11-01' AND created_at < '2022-12-01' AND actor_login in ('ST-DDT', 'Shinigami92', 'import-brain', 'xDivisionByZerox', 'pkuczynski', 'prisis') GROUP BY actor_login, event_type ORDER BY actions DESC
SELECT actor_login, sum(commits) FROM github_events GROUP by actor_login
SELECT actor_login, sum(commits) FROM github_events GROUP by actor_login LIMIT 100
SELECT actor_login,count() FROM github_events GROUP by actor_login
SELECT actor_login,count() FROM github_events GROUP by actor_login LIMIT 10
SELECT area, count(distinct cell) FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56 GROUP by area
SELECT area, count(distinct cell) FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56 GROUP by area order by uniqExact(cell)
SELECT area, count(distinct cell) FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56 GROUP by area order by uniqExact(cell) desc
SELECT arrayJoin(NER) AS ingredient, count() AS c FROM recipes GROUP BY ingredient ORDER BY c DESC LIMIT 10
SELECT arrayJoin(NER) AS k, count() AS c FROM recipes GROUP BY k ORDER BY c DESC LIMIT 50
SELECT arrayJoin(NER) FROM recipes --WHERE title = 'Hot Granola'
SELECT arrayJoin(NER), COUNT(NER) FROM recipes GROUP BY arrayJoin(NER) ORDER BY COUNT(NER) DESC
SELECT arrayJoin(NER), NER FROM recipes WHERE title = 'Shuku Shuku'
SELECT arrayJoin(NER), count(NER) FROM recipes GROUP BY arrayJoin(NER) ORDER by count(NER) DESC
SELECT arrayJoin(NER), title FROM recipes LIMIT 10
SELECT arrayJoin(directions) FROM recipes WHERE title = 'Cake' LIMIT 10
SELECT arrayJoin(labels) AS label, count() AS c FROM github_events WHERE (event_type IN ('IssuesEvent', 'PullRequestEvent', 'IssueCommentEvent')) AND (action IN ('created', 'opened', 'labeled')) AND ((label ILIKE '%bug%') OR (label ILIKE '%feature%')) GROUP BY label ORDER BY c DESC LIMIT 50
SELECT arrayJoin(labels) AS label, count() AS c FROM github_events WHERE (event_type IN ('PullRequestEvent')) AND (action IN ('created', 'opened', 'labeled')) AND ((label ILIKE '%bug%') OR (label ILIKE '%feature%')) GROUP BY label ORDER BY c DESC LIMIT 50
SELECT arrayJoin(labels) AS label, count() AS c FROM github_events WHERE (event_type IN ('PullRequestEvent')) AND (action IN ('created', 'opened', 'labeled')) AND ((label ILIKE '%python%')) GROUP BY label ORDER BY c DESC LIMIT 50
SELECT arrayJoin(labels) AS label, count() AS c FROM github_events WHERE (event_type IN ('PullRequestEvent')) AND (action IN ('labeled')) AND ((label ILIKE '%bug%') OR (label ILIKE '%feature%')) GROUP BY label ORDER BY c DESC LIMIT 50
SELECT author, day, any(day) OVER (PARTITION BY author ORDER BY day ASC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS previous_commit, dateDiff('day', previous_commit, day) AS days_since_last, if(days_since_last = 1, 1, 0) AS consecutive_day FROM ( SELECT author, toStartOfDay(time) AS day FROM git_clickhouse.commits GROUP BY author, day ORDER BY author ASC, day ASC ) LIMIT 10
SELECT author, score FROM reddit
SELECT author, toDate(day) as day, any(day) OVER (PARTITION BY author ORDER BY day ASC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS previous_commit, dateDiff('day', previous_commit, day) AS day_diff, if(day_diff = 1, 1, 0) AS consecutive FROM ( SELECT author, toStartOfDay(time) AS day FROM git_clickhouse.commits GROUP BY author, day ORDER BY author ASC, day ASC ) LIMIT 10
SELECT author, toDate(day) as day, any(day) OVER (PARTITION BY author ORDER BY day ASC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS previous_commit, dateDiff('day', previous_commit, day) AS day_diff, if(day_diff = 1, 1, 0) AS consecutive FROM ( SELECT author, toStartOfDay(time) AS day FROM git_clickhouse.commits GROUP BY author, day, author ORDER BY author ASC, day ASC ) LIMIT 1000000
SELECT author, toDate(day) as day, any(day) OVER (PARTITION BY author ORDER BY day ASC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS previous_commit, dateDiff('day', previous_commit, day) AS day_diff, if(day_diff = 1, 1, 0) AS consecutive FROM ( SELECT author, toStartOfDay(time) AS day FROM git_clickhouse.commits GROUP BY author, day, day ORDER BY author ASC, day ASC ) LIMIT 1000000
SELECT author, toDate(day) as day, any(day) OVER (PARTITION BY author ORDER BY day ASC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS previous_commit, dateDiff('day', previous_commit, day) AS day_diff, if(day_diff = 1, 1, 0) AS consecutive FROM ( SELECT author, toStartOfDay(time) AS day FROM git_clickhouse.commits GROUP BY day, author ORDER BY author ASC, day ASC ) LIMIT 1000000
SELECT author, toDate(day) as day, any(day) OVER (PARTITION BY author ORDER BY day ASC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS previous_commit, dateDiff('day', previous_commit, day) AS day_diff, if(day_diff = 1, 1, 0) AS consecutive FROM ( SELECT author, toStartOfDay(time) AS day FROM git_clickhouse.commits GROUP BY day, author ORDER BY day ASC, author ASC ) LIMIT 1000000
SELECT author, toDate(day) as day, any(day) OVER (PARTITION BY author ORDER BY day ASC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS previous_commit, dateDiff('day', previous_commit, day) AS day_diff, if(day_diff = 1, 1, 0) AS consecutive FROM ( SELECT author, toStartOfDay(time) AS day FROM git_clickhouse.commits GROUP BY day, author ORDER BY day ASC, day ASC ) LIMIT 1000000
SELECT author, toStartOfDay(time) AS day FROM git_clickhouse.commits GROUP BY author, day ORDER BY author ASC, day ASC LIMIT 10
SELECT avg(c1) FROM ( SELECT Year, Month, count(*) AS c1 FROM ontime GROUP BY Year, Month )
SELECT avg(cnt) FROM ( SELECT Year,Month,count(*) AS cnt FROM ontime WHERE DepDel15=1 GROUP BY Year,Month )
SELECT avg(geoDistance(longitude_1, latitude_1, longitude_2, latitude_2)) FROM opensky
SELECT avg(rls_cnt) FROM ( SELECT repo_name, count() as rls_cnt FROM github_events join repos on repo_name = full_name WHERE event_type = 'ReleaseEvent' and language='Python' GROUP by repo_name order by rls_cnt DESC )
SELECT avg(samples) as a, radio, min(created) as min_cr,max(created) as max_cr, min(updated) as min_upd,max(updated) as max_upd, sum(case when updated=created then 1 else 0 end) as ddd FROM cell_towers WHERE lat>=54 and lat<=56 and lon<=56 and lon>=54 GROUP by radio order by a desc
SELECT avg(tip_amount) FROM trips
SELECT by, count() AS c, sum(score), round(sum(score) * (1 - 1 / sqrt(c)) AS weight) AS w_round, sum(descendants), round(avg(score), 2) AS avg_score, round(avgIf(score, score >= 5), 2) AS score_passed, round(avg(score >= 5), 2) AS ratio_passed FROM hackernews WHERE type = 'story' GROUP BY by ORDER BY weight DESC LIMIT 1000
SELECT c.author, COUNT(c.hash) AS commit_count, MIN(c.`time`) AS first_commit, max(c.`time`) AS last_commit FROM git_clickhouse.commits c GROUP BY c.author ORDER BY commit_count
SELECT c.author, COUNT(c.hash) AS commit_count, MIN(c.`time`) AS first_commit, max(c.`time`) AS last_commit FROM git_clickhouse.commits c GROUP BY c.author ORDER BY commit_count DESC
SELECT c.author, COUNT(c.hash) OVER () FROM git_clickhouse.commits c
SELECT c.author, COUNT(c.hash) OVER (ORDER BY c.author) FROM git_clickhouse.commits c
SELECT c.author, COUNT(c.hash) OVER (ORDER BY c.hash) FROM git_clickhouse.commits c
SELECT c.author, COUNT(c.hash) OVER (PARTITION BY c.author) FROM git_clickhouse.commits c
SELECT c.author, COUNT(c.hash) as commit_count, MIN(c.`time`) as first_commit, max(c.`time`) as last_commit FROM git_clickhouse.commits c GROUP BY c.author
SELECT c.author, COUNT(c.hash) as commit_count, MIN(c.`time`) as first_commit, max(c.`time`) as last_commit FROM git_clickhouse.commits c GROUP BY c.author ORDER BY COUNT(c.hash)
SELECT c.author, COUNT(c.hash) as commit_count, MIN(c.`time`) as first_commit, max(c.`time`) as last_commit FROM git_clickhouse.commits c GROUP BY c.author ORDER BY COUNT(c.hash) DESC
SELECT c.author, COUNT(c.hash) as commit_count, MIN(c.`time`) as first_commit, max(c.`time`) as last_commit FROM git_clickhouse.commits c GROUP BY c.author ORDER BY c.author
SELECT cab_type, count(*) FROM trips GROUP BY cab_type
SELECT cab_type, count(*) as cnt FROM trips GROUP by cab_type
SELECT cell FROM cell_towers WHERE lat > 54 AND lat < 56 AND lon > 54 AND lon < 56
SELECT cell FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56
SELECT cell, COUNT (cell) FROM cell_towers WHERE lon BETWEEN 54 AND 56 AND lat BETWEEN 54 AND 56 GROUP BY cell ORDER BY COUNT (cell) DESC
SELECT cell, COUNT(cell) FROM cell_towers WHERE lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56 GROUP BY cell
SELECT cell, COUNT(radio) FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon > 54 AND lon < 56 AND lat > 54 GROUP BY cell
SELECT cell, COUNT(radio) FROM cell_towers WHERE lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56 GROUP BY cell
SELECT cell, Count (cell) From cell_towers Where '54'<lat< '56' and '54'<lon<'56' Group by cell Order by Count (cell) Desc
SELECT cell, Count (cell) From cell_towers Where lat> '0' and lon > '0' Group by cell Order by Count (cell) Desc
SELECT cell, count(distinct area) FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56 GROUP by cell
SELECT cell, count(radio) FROM cell_towers WHERE lat > 54 and lat < 56 and lon > 54 and lon < 56 GROUP BY cell ORDER BY count(radio)
SELECT cell, count(radio) FROM cell_towers WHERE lat > 54 and lat < 56 and lon > 54 and lon < 56 GROUP BY cell ORDER BY count(radio) DESC
SELECT cell, count(radio) FROM cell_towers WHERE lat > 54 and lat < 56 and lon > 54 and lon < 56 and radio = 'UMTS' GROUP BY cell ORDER BY count(radio)
SELECT cell, count(radio) FROM cell_towers WHERE lat > 54 and lat < 56 and lon > 54 and lon < 56 and radio = 'UMTS' GROUP BY cell ORDER BY count(radio) DESC
SELECT cell, count(radio) FROM cell_towers WHERE lat between 54 AND 56 AND lon between 54 AND 56 GROUP by cell
SELECT cell, count(radio) FROM cell_towers WHERE lat between 54 AND 56 AND lon between 54 AND 56 GROUP by cell ORDER by count(radio) DESC
SELECT cell,radio, COUNT(radio) FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon > 54 AND lon < 56 AND lat > 54 GROUP BY cell,radio
SELECT check_name, check_start_time FROM default.checks LIMIT 100
SELECT columns('price') FROM uk_price_paid LIMIT 10
SELECT count() AS c FROM cell_towers
SELECT count() AS c FROM recipes
SELECT count() FROM ( SELECT repo_name, count() AS stars FROM github_events WHERE event_type = 'WatchEvent' GROUP BY repo_name ORDER BY stars DESC LIMIT 50 )
SELECT count() FROM ( SELECT repo_name, count() AS stars FROM github_events WHERE event_type = 'WatchEvent'GROUP BY repo_name )
SELECT count() FROM blogs.countries
SELECT count() FROM blogs.countries LIMIT 5000
SELECT count() FROM blogs.country_codes LIMIT 5000
SELECT count() FROM blogs.forex LIMIT 5000
SELECT count() FROM blogs.forex_2020s LIMIT 5000
SELECT count() FROM blogs.forex_usd LIMIT 5000
SELECT count() FROM blogs.hackernews_json LIMIT 5000
SELECT count() FROM blogs.hackernews_json_v2
SELECT count() FROM blogs.hackernews_json_v2 LIMIT 5000
SELECT count() FROM blogs.http_logs LIMIT 5000
SELECT count() FROM blogs.noaa
SELECT count() FROM blogs.noaa LIMIT 5000
SELECT count() FROM blogs.noaa_v2 LIMIT 5000
SELECT count() FROM blogs.stop_words LIMIT 5000
SELECT count() FROM blogs.uk_codes LIMIT 5000
SELECT count() FROM cell_towers
SELECT count() FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56 and radio = 'GSM'
SELECT count() FROM cell_towers WHERE radio = 'GSM' and lon > 54 and lon < 56 and lat > 54 and lat < 56
SELECT count() FROM default.benchmark_results LIMIT 5000
SELECT count() FROM default.benchmark_runs LIMIT 5000
SELECT count() FROM default.cell_towers LIMIT 5000
SELECT count() FROM default.checks LIMIT 5000
SELECT count() FROM default.covid LIMIT 5000
SELECT count() FROM default.dish LIMIT 5000
SELECT count() FROM default.dns LIMIT 5000
SELECT count() FROM default.dns2 LIMIT 5000
SELECT count() FROM default.food_facts LIMIT 5000
SELECT count() FROM default.github_events LIMIT 5000
SELECT count() FROM default.hackernews LIMIT 5000
SELECT count() FROM default.hits
SELECT count() FROM default.hits LIMIT 5000
SELECT count() FROM default.hits WHERE EventDate < '2013-07-10' and EventDate > '2013-07-01'
SELECT count() FROM default.hits WHERE EventTime < '2022-10-10'
SELECT count() FROM default.hits WHERE JavaEnable = 1
SELECT count() FROM default.hits_100m_compatible LIMIT 5000
SELECT count() FROM default.lineorder LIMIT 5000
SELECT count() FROM default.loc_stats LIMIT 5000
SELECT count() FROM default.menu LIMIT 5000
SELECT count() FROM default.menu_item LIMIT 5000
SELECT count() FROM default.menu_item_denorm LIMIT 5000
SELECT count() FROM default.menu_page LIMIT 5000
SELECT count() FROM default.minicrawl LIMIT 5000
SELECT count() FROM default.ontime LIMIT 5000
SELECT count() FROM default.opensky LIMIT 5000
SELECT count() FROM default.primes LIMIT 5000
SELECT count() FROM default.query_metrics_v2 LIMIT 5000
SELECT count() FROM default.rdns LIMIT 5000
SELECT count() FROM default.recipes LIMIT 5000
SELECT count() FROM default.reddit LIMIT 5000
SELECT count() FROM default.repos LIMIT 5000
SELECT count() FROM default.repos_raw LIMIT 5000
SELECT count() FROM default.run_attributes_v1 LIMIT 5000
SELECT count() FROM default.stock LIMIT 5000
SELECT count() FROM default.tokens LIMIT 5000
SELECT count() FROM default.trips LIMIT 5000
SELECT count() FROM default.uk_price_paid LIMIT 5000
SELECT count() FROM default.wikistat LIMIT 5000
SELECT count() FROM dish
SELECT count() FROM food_facts
SELECT count() FROM git_clickhouse.commits
SELECT count() FROM github_events WHERE event_type = 'WatchEvent'
SELECT count() FROM github_events WHERE event_type = 'WatchEvent' AND repo_name IN ('ClickHouse/ClickHouse', 'yandex/ClickHouse') GROUP BY action
SELECT count() FROM lineorder --SELECT count() FROM wikistat
SELECT count() FROM menu WHERE event = 'LUNCH'
SELECT count() FROM menu WHERE event = 'LUNCH' or event = 'DINNER'
SELECT count() FROM menu_item_denorm
SELECT count() FROM primes
SELECT count() FROM query_metrics_v2
SELECT count() FROM reddit
SELECT count() FROM repos
SELECT count() FROM stock
SELECT count() FROM stock LIMIT 1
SELECT count() FROM tokens
SELECT count() FROM wikistat
SELECT count() as star_count FROM ( SELECT repo_name, count() AS stars FROM github_events WHERE event_type = 'WatchEvent'GROUP BY repo_name ) WHERE stars > 500
SELECT count(), author FROM git_clickhouse.commits WHERE message like 'Merge %' GROUP by author
SELECT count(), author FROM git_clickhouse.commits WHERE message like 'Merge %' GROUP by author order by count() desc
SELECT count(), sum(event_type = 'MemberEvent') AS invitations, sum(event_type = 'WatchEvent') AS stars FROM github_events WHERE event_type IN ('MemberEvent', 'WatchEvent') AND repo_name = 'koppi/iso-country-flags-svg-collection' GROUP BY repo_name HAVING stars >= 100 ORDER BY invitations DESC LIMIT 50
SELECT count(), sum(event_type = 'MemberEvent') AS invitations, sum(event_type = 'WatchEvent') AS stars FROM github_events WHERE event_type IN ('MemberEvent', 'WatchEvent') GROUP BY repo_name HAVING stars >= 100 ORDER BY invitations DESC LIMIT 50
SELECT count(*) FROM (SELECT * FROM (SELECT * FROM hits WHERE EventTime > '2010-07-15 19:26:13') A) B
SELECT count(*) FROM (SELECT * FROM hits WHERE EventTime > '2000-07-15 19:26:13' order by EventTime desc)
SELECT count(*) FROM (SELECT * FROM hits WHERE EventTime > '2000-07-15 19:26:13')
SELECT count(*) FROM benchmark_runs
SELECT count(*) FROM cell_towers WHERE lat>=54 and lat<=56 and lon<=56 and lon>=54 and radio='GSM'
SELECT count(*) FROM covid GROUP by new_confirmed
SELECT count(*) FROM default.benchmark_results
SELECT count(*) FROM default.hits
SELECT count(*) FROM github_events WHERE file_time>='2022-01-01 00:00:00'
SELECT count(*) FROM github_events WHERE labels <>'[]' LIMIT 70000000
SELECT count(*) FROM hits
SELECT count(*) FROM hits WHERE EventTime > '2000-07-15 19:26:13'
SELECT count(*) FROM hits_100m_obfuscated WHERE match(URL, '(d[a-f][f-z]0)')
SELECT count(*) FROM hits_100m_obfuscated WHERE match(URL, '(slo|va|de|rus)') or 1
SELECT count(*) FROM menu
SELECT count(*) FROM ontime
SELECT count(*) FROM query_metrics_v2
SELECT count(*) FROM tokens
SELECT count(*) FROM trips
SELECT count(*) FROM wikistat
SELECT count(*) as a, cell FROM cell_towers WHERE lat>=54 and lat<=56 and lon<=56 and lon>=54 GROUP by cell order by a desc
SELECT count(*) as a, radio FROM cell_towers WHERE lat>=54 and lat<=56 and lon<=56 and lon>=54 GROUP by radio order by a
SELECT count(*) as count FROM hits
SELECT count(*) as count FROM hits GROUP by substringUTF8(toString(EventTime),1,10)
SELECT count(*) as total,'0' as type FROM hits
SELECT count(*), count(distinct *) FROM cell_towers
SELECT count(*), deleted FROM hackernews GROUP by deleted
SELECT count(*), new_confirmed FROM covid GROUP by new_confirmed
SELECT count(*), new_confirmed FROM covid GROUP by new_confirmed order by new_confirmed
SELECT count(*), new_confirmed FROM covid WHERE new_confirmed > 0 GROUP by new_confirmed order by new_confirmed
SELECT count(*), radio FROM cell_towers WHERE lat>=54 and lat<=56 and lon<=56 and lon>=54 GROUP by radio
SELECT count(1) AS c FROM cell_towers
SELECT count(1) AS total, location_key FROM covid GROUP BY location_key ORDER BY total DESC LIMIT 10
SELECT count(1) FROM benchmark_results
SELECT count(1) FROM cell_towers
SELECT count(1) FROM covid -- LIMIT 10
SELECT count(1) FROM dns
SELECT count(1) FROM food_facts
SELECT count(1) FROM git_clickhouse.file_changes
SELECT count(1) FROM github_events -- show tables
SELECT count(1) FROM github_events WHERE file_time>='2022-01-01 00:00:00'
SELECT count(1) FROM github_events WHERE file_time>='2022-11-01 00:00:00' LIMIT 10
SELECT count(1) FROM hits_100m_compatible
SELECT count(1) FROM hits_100m_obfuscated WHERE toDate(ClientEventTime)>'2013-07-01'
SELECT count(1) FROM opensky
SELECT count(1) FROM query_metrics_v2
SELECT count(1) FROM recipes
SELECT count(1) FROM tokens
SELECT count(1) FROM uk_price_paid
SELECT count(1) FROM uk_price_paid -- show tables
SELECT count(1) FROM uk_price_paid WHERE date >= '2020-01-01'
SELECT count(1) FROM wikistat LIMIT 10
SELECT count(1) as c FROM stock LIMIT 5
SELECT count(1) as count FROM stock WHERE date>'2000-01-01'
SELECT count(1), avg(trip_distance), count(distinct vendor_id), avg(total_amount) FROM trips WHERE dropoff_date > pickup_date
SELECT count(1), avg(trip_distance), count(distinct vendor_id), avg(total_amount) FROM trips WHERE pickup = dropoff
SELECT count(1), location_key FROM covid GROUP BY location_key LIMIT 10
SELECT count(1), vendor_id, toRelativeQuarterNum(pickup_datetime) as Stamp FROM trips GROUP by Stamp, vendor_id order by Stamp desc
SELECT count(1), vendor_id, toStartOfMinute(pickup_datetime) as Stamp FROM trips GROUP by Stamp, vendor_id order by Stamp desc
SELECT count(1), vendor_id, toStartOfMinute(pickup_datetime) as Stamp FROM trips GROUP by toStartOfMinute(pickup_datetime), vendor_id
SELECT count(1), vendor_id, toStartOfMinute(pickup_datetime) as Stamp FROM trips GROUP by toStartOfMinute(pickup_datetime), vendor_id order by Stamp
SELECT count(1), vendor_id, toStartOfMinute(pickup_datetime) as Stamp FROM trips GROUP by toStartOfMinute(pickup_datetime), vendor_id order by Stamp desc
SELECT count(1), vendor_id, toStartOfMinute(pickup_datetime) as Stamp FROM trips GROUP by toStartOfMinute(pickup_datetime), vendor_id order by toStartOfMinute(pickup_datetime)
SELECT count(1)/1000000000 FROM github_events -- show tables
SELECT count(CLID) FROM hits
SELECT count(CounterID) FROM hits
SELECT count(Title) FROM hits
SELECT count(UserID) FROM hits
SELECT count(WatchID) FROM hits
SELECT count(area) FROM cell_towers
SELECT count(cell) FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56 order by uniqExact(cell) desc
SELECT count(created_at) FROM github_events WHERE event_type = 'IssuesEvent' and (repo_name = 'leo-yuriev/libmdbx' or repo_name = 'erthink/libmdbx') GROUP BY created_at ORDER BY created_at ASC
SELECT count(date) FROM uk_price_paid
SELECT count(distinct *) FROM cell_towers
SELECT count(distinct *)=count(*) FROM cell_towers
SELECT count(distinct CLID) FROM hits
SELECT count(distinct CounterID) FROM hits
SELECT count(distinct GoodEvent) FROM (SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID) as a inner join hits_100m_compatible on hits_100m_compatible.CounterID = a.CounterID and hits_100m_compatible.RegionID = a.maxRegionID
SELECT count(distinct GoodEvent), count(distinct GoodEvent, UserAgent), count(distinct UserAgent) FROM (SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID) as a inner join hits_100m_compatible on hits_100m_compatible.CounterID = a.CounterID and hits_100m_compatible.RegionID = a.maxRegionID
SELECT count(distinct GoodEvent), count(distinct GoodEvent, UserID), count(distinct UserID) FROM (SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID) as a inner join hits_100m_compatible on hits_100m_compatible.CounterID = a.CounterID and hits_100m_compatible.RegionID = a.maxRegionID
SELECT count(distinct GoodEvent), count(distinct GoodEvent, WatchID) FROM (SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID) as a inner join hits_100m_compatible on hits_100m_compatible.CounterID = a.CounterID and hits_100m_compatible.RegionID = a.maxRegionID
SELECT count(distinct GoodEvent), count(distinct WatchID) FROM (SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID) as a inner join hits_100m_compatible on hits_100m_compatible.CounterID = a.CounterID and hits_100m_compatible.RegionID = a.maxRegionID
SELECT count(distinct UserID), count(distinct UserID, UserAgent), count(distinct UserAgent) FROM (SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID) as a inner join hits_100m_compatible on hits_100m_compatible.CounterID = a.CounterID and hits_100m_compatible.RegionID = a.maxRegionID
SELECT count(distinct UserID), count(distinct UserID, UserAgent), count(distinct UserAgent), sum(distinct UserAgent) FROM (SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID) as a inner join hits_100m_compatible on hits_100m_compatible.CounterID = a.CounterID and hits_100m_compatible.RegionID = a.maxRegionID
SELECT count(distinct UserID), count(distinct UserID, UserAgent), sum(distinct UserAgent) FROM (SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID) as a inner join hits_100m_compatible on hits_100m_compatible.CounterID = a.CounterID and hits_100m_compatible.RegionID = a.maxRegionID
SELECT count(distinct area) FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56
SELECT count(distinct event_type) FROM github_events
SELECT count(distinct lat)=count(lat) FROM cell_towers LIMIT 100
SELECT count(distinct lon) FROM cell_towers
SELECT count(distinct radio) FROM cell_towers LIMIT 100
SELECT count(distinct radio) FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56
SELECT count(distinct radio)=count() FROM cell_towers LIMIT 100
SELECT count(distinct radio)=count(radio) FROM cell_towers LIMIT 100
SELECT count(distinct radio,mcc) FROM cell_towers LIMIT 100
SELECT count(distinct ru.date) FROM (SELECT sum(new_tested) as new_tested, date FROM covid WHERE location_key = 'RU' GROUP BY date) as ru Inner Join (SELECT sum(new_tested) as new_tested, date FROM covid WHERE location_key = 'KZ' GROUP BY date) as kz ON ru.date = kz.date WHERE ru.new_tested < kz.new_tested
SELECT count(distinct vendor_id) FROM trips WHERE pickup = dropoff
SELECT count(distinct(lon)) FROM cell_towers
SELECT count(event_type) FROM github_events
SELECT count(id) FROM dish d1 join dish d2 on d1.name = d2.name
SELECT count(id), deleted FROM hackernews GROUP by deleted
SELECT count(lon) = count(distinct lon) FROM cell_towers LIMIT 100
SELECT count(lowest_price) FROM dish
SELECT count(mcc) FROM cell_towers
SELECT count(menus_appeared) FROM dish
SELECT count(net) FROM cell_towers
SELECT count(radio) = count(distinct radio) FROM cell_towers LIMIT 100
SELECT count(radio) FROM cell_towers LIMIT 100
SELECT count(radio) FROM cell_towers WHERE lat > '67' GROUP by radio
SELECT count(radio) FROM cell_towers WHERE lat > 0 and lon > 0
SELECT count(radio) FROM cell_towers WHERE lat > 0 and lon > 0 GROUP by radio
SELECT count(radio) FROM cell_towers WHERE lat > 54 and lat < 56 and lon > 54 and lon < 56 GROUP BY radio ORDER BY count(radio) DESC
SELECT count(radio) FROM cell_towers WHERE lat > 54 and lat < 56 and lon > 54 and lon < 56 and radio = 'GSM'
SELECT count(repo_name) FROM github_events WHERE event_type = 'IssuesEvent' and (repo_name = 'leo-yuriev/libmdbx' or repo_name = 'erthink/libmdbx') GROUP BY repo_name ORDER BY repo_name ASC
SELECT count(vendor_id), toStartOfMinute(pickup_datetime) as Stamp FROM trips GROUP by toStartOfMinute(pickup_datetime)
SELECT countDistinct(*) FROM hits
SELECT county, avg(price) FROM uk_price_paid GROUP BY county ORDER BY avg(price) DESC LIMIT 3
SELECT county, count(*) FROM uk_price_paid GROUP by county
SELECT county, price FROM uk_price_paid WHERE town = 'LONDON' ORDER BY price DESC LIMIT 3
SELECT created_at, event_type, repo_name, number as issue, action, title, actor_login as actor, labels FROM github_events WHERE event_type = 'IssuesEvent' and repo_name = 'facebook/react' and toDate(created_at) = '2022-03-03' order by created_at LIMIT 100
SELECT created_at, event_type, repo_name, number as issue, action, title, actor_login as actor, labels FROM github_events WHERE event_type = 'IssuesEvent' and repo_name in ('ClickHouse/ClickHouse','yandex/ClickHouse') order by created_at desc LIMIT 100
SELECT cutToFirstSignificantSubdomain(domain) AS d, count() AS c FROM rdns GROUP BY d ORDER BY c DESC LIMIT 50
SELECT date AS "Дата", sumIf(new_tested, date > '2020-01-01' and date <'2020-12-31') AS "Тестированных", sumIf(new_confirmed, date > '2020-01-01' and date <'2020-12-31') AS "Заражений", sumIf(new_deceased, date > '2020-01-01' and date <'2020-12-31') AS "Умерших", sumIf(new_recovered, date > '2020-01-01' and date <'2020-12-31') AS "Вылечившихся" FROM covid GROUP by date
SELECT date AS "Дата", sumIf(new_tested, date > '2020-01-01' and date <'2020-12-31') AS "Тестированных", sumIf(new_confirmed, date > '2020-01-01' and date <'2020-12-31') AS "Зараженных", sumIf(new_deceased, date > '2020-01-01' and date <'2020-12-31') AS "Умерших", sumIf(new_recovered, date > '2020-01-01' and date <'2020-12-31') AS "Вылечившихся" FROM covid GROUP by date
SELECT date AS "Дата", sumIf(new_tested, date > '2020-01-01' and date <'2020-12-31') AS "Тестированных", sumIf(new_confirmed, date > '2020-01-01' and date <'2020-12-31') AS "Зараженных", sumIf(new_deceased, date > '2020-01-01' and date <'2020-12-31') AS "Умерших", sumIf(new_recovered, date > '2020-01-01' and date <'2020-12-31') AS "Вылечившихся" FROM covid GROUP by date order by date
SELECT date AS `__timestamp`, min(`count`) AS `MIN(count)` FROM (SELECT toStartOfMonth(created_at) as date, SUM (commits) as count FROM `default`.`github_events` GROUP by date order by date) AS `virtual_table` GROUP BY date ORDER BY `MIN(count)` DESC LIMIT 100
SELECT date, groupArray( (location_key, new_tested) ) AS state FROM (SELECT date, location_key, SUM(new_tested) AS new_tested FROM covid GROUP BY date, location_key) WHERE location_key in ('RU', 'KZ', 'BY') GROUP BY date
SELECT date, groupArray( (location_key, new_tested) ) AS stats FROM ( SELECT date, location_key, SUM(new_tested) AS new_tested FROM covid GROUP BY date, location_key ) GROUP BY date
SELECT date, groupArray( (location_key, new_tested) ) AS stats FROM ( SELECT date, location_key, SUM(new_tested) AS new_tested FROM covid WHERE location_key IN ('RU', 'BY', 'KZ') GROUP BY date, location_key ) GROUP BY date
SELECT date, groupArray( (location_key, nt) ) as lc FROM ( SELECT date, location_key, SUM(new_tested) as nt FROM covid WHERE location_key in ['RU', 'BY', 'KZ'] GROUP by (date, location_key) ) GROUP by date having arrayCount(l->(l.1 in ('RU', 'KZ')) and l.2>0, lc) == 2
SELECT date, groupArray( (location_key, nt) ) as lc FROM ( SELECT date, location_key, SUM(new_tested) as nt FROM covid WHERE location_key in ['RU', 'BY', 'KZ'] GROUP by (date, location_key) ) GROUP by date having arraySum(arrayMap(l->(l.1 in ('RU', 'KZ')) and l.2>0, lc)) == 2
SELECT date, location_key FROM covid
SELECT date, location_key FROM covid LIMIT 10
SELECT date, location_key FROM default.covid LIMIT 100
SELECT date, location_key, SUM(new_tested) AS new_tested FROM covid GROUP BY date, location_key
SELECT date, location_key, SUM(new_tested) AS new_tested FROM covid WHERE location_key IN ('RU', 'BY', 'KZ') GROUP BY date, location_key
SELECT date, max(new_confirmed) FROM covid GROUP by date
SELECT date, new_tested as new_tested FROM covid WHERE location_key = 'RU'
SELECT date, sum(new_confirmed) FROM covid GROUP by toYYYYMM(date) as date
SELECT date, sumIf(new_confirmed, date > '2020-01-01' and date <'2020-12-31'), sumIf(new_deceased, date > '2020-01-01' and date <'2020-12-31'), sumIf(new_recovered, date > '2020-01-01' and date <'2020-12-31'), sumIf(new_tested, date > '2020-01-01' and date <'2020-12-31') FROM covid GROUP by date
SELECT date, sumIf(new_tested, date > '2020-01-01' and date <'2020-12-31') AS "Тестированных", sumIf(new_confirmed, date > '2020-01-01' and date <'2020-12-31') AS "Заражений", sumIf(new_deceased, date > '2020-01-01' and date <'2020-12-31') AS "Умерших", sumIf(new_recovered, date > '2020-01-01' and date <'2020-12-31') AS "Вылечившихся" FROM covid GROUP by date
SELECT datetime, bid, ask, base, quote FROM blogs.forex LIMIT 100
SELECT day_of_week, author, count() AS c FROM git_clickhouse.commits WHERE time > (now() - toIntervalYear(1)) GROUP BY dayOfWeek(time) AS day_of_week, author ORDER BY day_of_week ASC, c DESC LIMIT 1 BY day_of_week
SELECT day_of_week, author, count() AS c FROM git_clickhouse.commits WHERE time > date_sub(YEAR, 1, now()) GROUP BY dayOfWeek(time) AS day_of_week, author ORDER BY day_of_week ASC, c DESC LIMIT 1 BY day_of_week
SELECT destination , COUNT(destination) FROM opensky WHERE NOT empty(origin) GROUP BY destination ORDER BY COUNT(destination) DESC
SELECT destination origin , COUNT(destination) FROM opensky WHERE NOT empty(destination) GROUP BY destination ORDER BY COUNT(destination) desc
SELECT destination origin , COUNT(destination) FROM opensky WHERE NOT empty(origin) GROUP BY destination ORDER BY COUNT(destination) DESC
SELECT destination origin , COUNT(destination) FROM opensky WHERE NOT empty(origin) GROUP BY destination ORDER BY COUNT(destination) asc
SELECT destination origin , COUNT(destination) FROM opensky WHERE NOT empty(origin) GROUP BY destination ORDER BY COUNT(destination) desc
SELECT destination origin , COUNT(destination) FROM opensky WHERE empty(destination) GROUP BY destination ORDER BY COUNT(destination) desc
SELECT destination origin , COUNT(destination) FROM opensky WHERE not empty(destination) GROUP BY destination ORDER BY COUNT(destination) desc
SELECT destination, COUNT(destination) FROM opensky GROUP BY destination
SELECT destination, COUNT(destination) FROM opensky GROUP BY destination ORDER BY COUNT(destination) ASC
SELECT destination, COUNT(destination) FROM opensky GROUP BY destination ORDER BY COUNT(destination) DESC
SELECT destination, COUNT(destination) FROM opensky GROUP by destination
SELECT destination, COUNT(destination) FROM opensky WHERE NOT empty(destination) GROUP BY destination ORDER BY COUNT(destination) DESC
SELECT destination, COUNT(destination) FROM opensky WHERE not empty(destination) GROUP by destination
SELECT destination, COUNT(destination) FROM opensky Where not empty(destination) GROUP BY destination ORDER BY COUNT(destination) DESC
SELECT destination, COUNT(origin) FROM opensky WHERE not empty(destination) GROUP by destination
SELECT destination, COUNT(origin) FROM opensky WHERE not empty(destination) GROUP by destination Order by destination Desc
SELECT destination, COUNT(origin) as cnt FROM opensky WHERE not empty(destination) GROUP by destination Order by cnt Desc
SELECT destination, COUNT(origin)as cnt FROM opensky WHERE not empty(origin) and not empty(destination) GROUP by destination Order by cnt DESC
SELECT destination, MAX(origin) as max FROM opensky WHERE not empty(origin) and not empty(destination) GROUP by destination
SELECT destination, count(origin) as cnt FROM opensky WHERE not empty(origin) and not empty(destination) GROUP by destination Order by cnt DESC
SELECT destination, origin FROM opensky
SELECT destination, origin FROM opensky WHERE not empty(origin)
SELECT destination, origin FROM opensky WHERE not empty(origin) and not empty(destination)
SELECT distinct FromTag FROM hits_100m_obfuscated
SELECT distinct area FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56
SELECT distinct area, cell FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56
SELECT distinct area, cell FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56 order by cell
SELECT distinct area, cell FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56 order by cell desc
SELECT distinct area, count(cell) FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56 GROUP by area order by uniqExact(cell) desc
SELECT distinct area, count(distinct cell) FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56 GROUP by area order by uniqExact(cell) desc
SELECT distinct author FROM reddit
SELECT distinct cell, count(cell) FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56 GROUP by cell order by uniqExact(cell)
SELECT distinct cell, count(cell) FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56 GROUP by cell order by uniqExact(cell) desc
SELECT distinct count(author) FROM reddit
SELECT distinct destination, COUNT(origin) FROM opensky WHERE not empty(destination) and not empty(origin) GROUP by destination
SELECT distinct destination, COUNT(origin) FROM opensky WHERE not empty(destination) and not empty(origin) GROUP by destination ORder by COUNT(origin) desc
SELECT distinct destination, COUNT(origin) FROM opensky WHERE not empty(origin) and not empty(destination) GROUP by destination
SELECT distinct destination, COUNT(origin) as cnt FROM opensky WHERE not empty(origin) and not empty(destination) GROUP by destination ORder by cnt DESC
SELECT distinct destination, origin FROM opensky
SELECT distinct destination, origin FROM opensky WHERE not empty(destination) and not empty(origin)
SELECT distinct full_name FROM repos LIMIT 10
SELECT distinct full_name, language, max(stargazers_count) as cnt FROM repos WHERE (language == 'Python') and (stargazers_count >= 150) and (stargazers_count <= 200) GROUP by full_name, language order by cnt desc
SELECT distinct full_name, language, max(stargazers_count) as cnt FROM repos WHERE (language == 'Python') and (stargazers_count >= 150) and (stargazers_count <= 200) GROUP by full_name, language order by cnt desc LIMIT 1000
SELECT distinct full_name, language, max(stargazers_count) as cnt FROM repos WHERE language == 'Python' GROUP by full_name, language order by cnt desc
SELECT distinct full_name, language, stargazers_count FROM repos LIMIT 10
SELECT distinct language FROM repos
SELECT distinct radio FROM cell_towers LIMIT 100
SELECT distinct toString(event_type) FROM github_events
SELECT distinct toString(event_type) FROM github_events LIMIT 10
SELECT distinct(CounterID) FROM hits
SELECT distinct(CounterID), max(RegionID) over (partition by CounterID) as maxRegionID FROM hits
SELECT distinct(CounterID, max(RegionID) over (partition by CounterID) as maxRegionID) FROM hits
SELECT distinct(GoodEvent) FROM (SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID) as a inner join hits_100m_compatible on hits_100m_compatible.CounterID = a.CounterID and hits_100m_compatible.RegionID = a.maxRegionID order by GoodEvent
SELECT distinct(GoodEvent) FROM (SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID) as a inner join hits_100m_compatible on hits_100m_compatible.CounterID = a.CounterID and hits_100m_compatible.RegionID = a.maxRegionID order by GoodEvent limit(10)
SELECT domainWithoutWWW(url) AS d, count() AS c, sum(score), round(sum(score) * (1 - 1 / sqrt(c)) AS weight) AS w_round, sum(descendants), round(avg(score), 2) AS avg_score, round(avgIf(score, score >= 5), 2) AS score_passed, round(avg(score >= 5), 2) AS ratio_passed FROM hackernews WHERE type = 'story' GROUP BY d ORDER BY weight DESC LIMIT 1000
SELECT dropoff, count(1) FROM trips WHERE dropoff_date > pickup_date GROUP by dropoff having count(1) > 1000000
SELECT elevation_range, max(tempMax) / 10 AS max_temp, min(tempMin) / 10 AS min_temp, sum(precipitation) AS total_precipitation, avg(percentDailySun) AS avg_percent_sunshine, max(maxWindSpeed) AS max_wind_speed FROM blogs.noaa WHERE (date > '1970-01-01') AND (station_id IN ( SELECT station_id FROM blogs.stations WHERE country_code = 'US' )) GROUP BY multiIf(elevation < 100, '< 100', elevation < 200, '100 < x < 200', '> 200') AS elevation_range
SELECT event as issue_status, COUNT(*) as cnt FROM ( SELECT event_type, repo_name, actor_login, action as event FROM github_events WHERE created_at::Date < '2019-01-21' AND event_type = 'IssuesEvent' ) GROUP by issue_status
SELECT event as issue_status, COUNT(*) as cnt FROM ( SELECT event_type, repo_name, actor_login, action as event FROM github_events WHERE created_at::Date = '2019-01-01' AND event_type = 'IssuesEvent' ) GROUP by issue_status
SELECT event_type FROM github_events WHERE created_at::Date = '2014-01-16' GROUP BY event_type
SELECT event_type FROM github_events WHERE startsWith(repo_name, 'substack/') AND (repo_name LIKE '%parse-messy-time%') AND (event_type NOT IN ('WatchEvent')) ORDER BY created_at ASC LIMIT 100
SELECT event_type FROM github_events WHERE startsWith(repo_name, 'substack/') AND (repo_name LIKE '%parse-messy-time%') AND (event_type NOT IN ('WatchEvent', 'ForkEvent')) ORDER BY created_at ASC LIMIT 100
SELECT event_type FROM github_events WHERE startsWith(repo_name, 'substack/') AND repo_name LIKE '%parse-messy-time%' GROUP BY event_type LIMIT 100
SELECT event_type FROM github_events WHERE startsWith(repo_name, 'substack/') AND repo_name LIKE '%parse-messy-time%' ORDER BY created_at ASC LIMIT 50
SELECT event_type, actor_login FROM github_events WHERE startsWith(repo_name, 'substack/') AND (repo_name LIKE '%parse-messy-time%') AND (event_type NOT IN ('WatchEvent', 'ForkEvent')) ORDER BY created_at ASC LIMIT 100
SELECT event_type, actor_login, action FROM github_events WHERE startsWith(repo_name, 'substack/') AND (repo_name LIKE '%parse-messy-time%') AND (event_type NOT IN ('WatchEvent', 'ForkEvent')) ORDER BY created_at ASC LIMIT 100
SELECT event_type, actor_login, action as event FROM github_events WHERE created_at::Date < '2013-01-16' AND actor_login = 'sergey-alekseev'
SELECT event_type, actor_login, action as event FROM github_events WHERE created_at::Date = '2019-01-16' AND actor_login = 'sergey-alekseev'
SELECT event_type, actor_login, action, path FROM github_events WHERE startsWith(repo_name, 'substack/') AND (repo_name LIKE '%parse-messy-time%') AND (event_type NOT IN ('WatchEvent', 'ForkEvent')) ORDER BY created_at ASC LIMIT 100
SELECT event_type, actor_login, action, path, title FROM github_events WHERE startsWith(repo_name, 'substack/') AND (repo_name LIKE '%parse-messy-time%') AND (event_type NOT IN ('WatchEvent', 'ForkEvent')) ORDER BY created_at ASC LIMIT 100
SELECT event_type, count() as count FROM github_events GROUP by event_type order by count desc
SELECT event_type, count(*) FROM github_events GROUP by event_type LIMIT 1000
SELECT event_type, creator_user_login FROM github_events WHERE startsWith(repo_name, 'substack/') AND (repo_name LIKE '%parse-messy-time%') AND (event_type NOT IN ('WatchEvent', 'ForkEvent')) ORDER BY created_at ASC LIMIT 100
SELECT event_type, creator_user_login FROM github_events WHERE startsWith(repo_name, 'substack/') AND repo_name LIKE '%parse-messy-time%' ORDER BY created_at ASC LIMIT 50
SELECT event_type, creator_user_login, actor_login FROM github_events WHERE startsWith(repo_name, 'substack/') AND (repo_name LIKE '%parse-messy-time%') AND (event_type NOT IN ('WatchEvent', 'ForkEvent')) ORDER BY created_at ASC LIMIT 100
SELECT event_type, repo_name, actor_login, action as event FROM github_events WHERE created_at::Date = '2019-01-21' AND actor_login = 'sergey-alekseev'
SELECT event_type, repo_name, actor_login, action as event FROM github_events WHERE created_at::Date = '2019-01-21' AND event_type = 'IssuesEvent'
SELECT exp10(floor(log10(c))) AS stars, uniq(k) FROM ( SELECT repo_name AS k, count() AS c FROM github_events WHERE event_type = 'WatchEvent' GROUP BY k ) GROUP BY stars ORDER BY stars ASC
SELECT file_time, event_type, actor_login, repo_name, created_at, updated_at, action, comment_id, body, path, position, line, ref, ref_type, creator_user_login, number, title, labels, state, locked, assignee, assignees, comments, author_association, closed_at, merged_at, merge_commit_sha, requested_reviewers, requested_teams, head_ref, head_sha, base_ref, base_sha, merged, mergeable, rebaseable, mergeable_state, merged_by, review_comments, maintainer_can_modify, commits, additions, deletions, changed_files, diff_hunk, original_position, commit_id, original_commit_id, push_size, push_distinct_size, member_login, release_tag_name, release_name, review_state FROM github_events WHERE startsWith(repo_name, 'substack/') AND (repo_name LIKE '%parse-messy-time%') AND (event_type NOT IN ('WatchEvent', 'ForkEvent')) ORDER BY created_at ASC LIMIT 100
SELECT flatten(NER) FROM recipes LIMIT 10
SELECT formatReadableQuantity(count()) FROM uk_price_paid
SELECT formatReadableQuantity(sum(geoDistance(longitude_1, latitude_1, longitude_2, latitude_2)) / 1000) , sum(geoDistance(longitude_1, latitude_1, longitude_2, latitude_2)) / 1000 FROM opensky LIMIT 100
SELECT formatReadableQuantity(sum(geoDistance(longitude_1, latitude_1, longitude_2, latitude_2)) / 1000) FROM opensky
SELECT formatReadableQuantity(sum(geoDistance(longitude_1, latitude_1, longitude_2, latitude_2)) / 1000) FROM opensky LIMIT 100
SELECT full_name, language FROM repos
SELECT full_name, language FROM repos WHERE language == 'Python'
SELECT full_name, language, max(stargazers_count) as cnt FROM repos WHERE (language == 'Python') and (stargazers_count >= 150) and (stargazers_count <= 200) GROUP by full_name, language order by cnt desc
SELECT groupArray(WatchID) FROM hits WHERE EventDate = '2013-07-15' and UserID = 15985305027620249815 LIMIT 10
SELECT groupArray(id) FROM reddit WHERE author = 'wjv'
SELECT groupArray(id) FROM reddit WHERE author = 'wjv' order by 1
SELECT groupUniqArray(20)(WatchID), Title FROM hits GROUP BY WatchID, Title LIMIT 10
SELECT groupUniqArray(WatchID), Title FROM hits GROUP BY WatchID, Title
SELECT groupUniqArray(WatchID), Title FROM hits GROUP BY WatchID, Title LIMIT 10
SELECT groupUniqArray(subreddit_type) FROM (SELECT * FROM reddit LIMIT 5) GROUP by author
SELECT groupUniqArray(subreddit_type), groupUniqArray(author) FROM (SELECT * FROM reddit LIMIT 5) GROUP by author
SELECT groupUniqArray(subreddit_type), groupUniqArray(author), groupUniqArray(created_date) FROM (SELECT * FROM reddit LIMIT 5) GROUP by author
SELECT has([1,2],1) FROM recipes LIMIT 10
SELECT hash, time FROM git_clickhouse.commits ORDER BY time DESC LIMIT 1
SELECT histogram(10)(max(new_tested)) FROM covid GROUP by new_tested
SELECT hits.WatchID FROM hits
SELECT hits.WatchID FROM hits -- and hits_100m_compatible WHERE hits.WatchID = hits_100m_compatible.WatchID limit(10)
SELECT hits.WatchID FROM hits limit(10)
SELECT kz.date FROM (SELECT date, SUM(new_tested) FROM covid WHERE location_key = 'RU' GROUP BY date) AS ru JOIN (SELECT date, SUM(new_tested) FROM covid WHERE location_key = 'KZ' GROUP BY date) AS kz ON ru.date = kz.date
SELECT language, count() FROM repos GROUP by 1
SELECT language, count() FROM repos GROUP by 1 order by 2 desc LIMIT 10
SELECT lat, COUNT(radio) FROM cell_towers WHERE lat >= 67 GROUP BY lat
SELECT lat, lon, radio, COUNT(radio) FROM cell_towers WHERE radio = 'GSM' AND lat >= 54 AND lat <= 56 AND lon >= 54 AND lon <= 56 GROUP BY radio, lat, lon
SELECT length(directions), length(NER) FROM recipes WHERE title = 'Hot Granola'
SELECT location_key, sum(new_confirmed) FROM covid GROUP by location_key
SELECT location_key, sum(new_confirmed), sum(new_deceased) FROM covid GROUP by location_key
SELECT location_key, sum(new_confirmed), sum(new_deceased), sum(new_recovered), sum(new_tested) FROM covid GROUP by location_key
SELECT location_key, sum(new_tested) AS "Тестированных", sum(new_confirmed) AS "Зараженных", sum(new_deceased) AS "Умерших", sum(new_recovered) AS "Вылечившихся" FROM covid GROUP by location_key
SELECT location_key, sumIf(new_confirmed, location_key='BR_RO_110037') FROM covid GROUP by location_key
SELECT location_key,count(1) as c FROM covid GROUP by location_key order by c
SELECT location_key,count(1) as c FROM covid GROUP by location_key order by c desc
SELECT lower(repo_name) as repo_name, count() as stars FROM github_events WHERE event_type = 'WatchEvent' GROUP by repo_name order by stars desc LIMIT 10
SELECT max(EventTime) FROM default.hits
SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID
SELECT max(RegionID) over (partition by CounterID) as maxRegionID FROM hits
SELECT max(date) FROM uk_price_paid
SELECT max(hits.RegionID), hits.CounterID FROM hits GROUP by CounterID
SELECT max(hits.RegionID), hits.CounterID FROM hits GROUP by CounterID limit(10)
SELECT max(new_confirmed) FROM covid
SELECT max(range) FROM cell_towers
SELECT max(time) FROM git_clickhouse.commits
SELECT mcc FROM cell_towers
SELECT mcc, count() FROM cell_towers GROUP BY mcc ORDER BY count() DESC
SELECT mcc, count() FROM cell_towers GROUP BY mcc ORDER BY count() DESC LIMIT 10
SELECT mcc,area FROM cell_towers
SELECT mcc,area,cell FROM cell_towers
SELECT mcc,area,cell,radio FROM cell_towers
SELECT mcc=640 FROM cell_towers
SELECT message, count() FROM git_clickhouse."commits" WHERE message ILIKE '%trash%' GROUP BY message ORDER BY count() DESC
SELECT metric,count() FROM query_metrics_v2 GROUP by metric
SELECT metric,count(*) FROM query_metrics_v2 GROUP by metric
SELECT min(Year), max(Year), IATA_CODE_Reporting_Airline AS Carrier, count(*) AS cnt, sum(ArrDelayMinutes>30) AS flights_delayed, round(sum(ArrDelayMinutes>30)/count(*),2) AS rate FROM ontime WHERE DayOfWeek NOT IN (6,7) AND OriginState NOT IN ('AK', 'HI', 'PR', 'VI') AND DestState NOT IN ('AK', 'HI', 'PR', 'VI') AND FlightDate < '2010-01-01' GROUP by Carrier HAVING cnt>100000 and max(Year)>1990 ORDER by rate DESC LIMIT 1000
SELECT min(`count`) AS `MIN(count)` FROM (SELECT toStartOfMonth(created_at) as date, SUM (commits) as count FROM `default`.`github_events` GROUP by date order by date) AS `virtual_table` ORDER BY `MIN(count)` DESC LIMIT 100
SELECT min(created) FROM cell_towers WHERE lat between 54 AND 56 AND lon between 54 AND 56 GROUP by radio
SELECT min(score) FROM reddit
SELECT min(time) FROM git_clickhouse.commits
SELECT mm, sum(new_confirmed) FROM covid GROUP by mm order by toYYYYMM(date) as mm
SELECT mm, sum(new_confirmed) FROM covid GROUP by mm order by toYYYYMM(date) as mm desc
SELECT mm, sum(new_confirmed) FROM covid GROUP by toYYYYMM(date) as mm order by toYYYYMM(date)
SELECT name FROM blogs.countries
SELECT name FROM blogs.countries LIMIT 10 
SELECT new_confirmed FROM covid order by new_confirmed 
SELECT new_confirmed FROM covid order by new_confirmed desc 
SELECT old_path AS path, max(time) AS last_time, 2 AS change_type FROM git_clickhouse.file_changes GROUP BY old_path UNION ALL SELECT path, max(time) AS last_time, argMax(change_type, time) AS change_type FROM git_clickhouse.file_changes GROUP BY path
SELECT origin destination, COUNT(destination) FROM opensky WHERE NOT empty(destination) GROUP BY destination ORDER BY COUNT(destination) DESC
SELECT origin, COUNT(origin) FROM opensky GROUP BY origin ORDER BY COUNT(origin) DESC
SELECT origin, COUNT(origin) FROM opensky WHERE NOT empty(origin) GROUP BY origin ORDER BY COUNT(origin) DESC
SELECT origin, COUNT(origin) FROM opensky WHERE not empty(destination) and not empty(origin) GROUP by origin
SELECT origin, COUNT(origin) FROM opensky Where not empty(origin) GROUP BY origin ORDER BY COUNT(origin) DESC
SELECT origin, COUNT(origin) cnt FROM opensky WHERE NOT empty(origin) GROUP by origin Order by cnt DESC
SELECT origin, COUNT(origin) cnt FROM opensky WHERE not empty(destination) and not empty(origin) GROUP by origin Order by cnt DESC
SELECT origin, COUNT(origin) cnt FROM opensky WHERE not empty(origin) GROUP by origin Order by cnt DESC
SELECT origin, count(), round(avg(geoDistance(longitude_1, latitude_1, longitude_2, latitude_2))) AS distance, bar(distance, 0, 10000000, 100) AS bar FROM opensky WHERE origin != '' GROUP BY origin ORDER BY count() DESC -- LIMIT 100
SELECT origin, count(*), count(distinct number) FROM opensky WHERE not empty(origin) GROUP by 1 order by 2 desc --SELECT * FROM opensky
SELECT origin, count(distinct number) as cnt FROM opensky WHERE 1=1 and not empty(origin) and not empty(number) and not empty(destination) GROUP by 1 order by 2 desc
SELECT origin, count(distinct number) as cnt FROM opensky WHERE 1=1 and origin is not null and number is not null and destination is not null GROUP by 1 order by 2 desc
SELECT passenger_count, toYear(pickup_date) AS year, round(trip_distance) AS distance, count(*) FROM trips GROUP BY passenger_count, year, distance ORDER BY year, count(*) DESC
SELECT path FROM ( SELECT old_path AS path, max(time) AS last_time, 2 AS change_type FROM git_clickhouse.file_changes GROUP BY old_path UNION ALL SELECT path, max(time) AS last_time, argMax(change_type, time) AS change_type FROM git_clickhouse.file_changes GROUP BY path ) GROUP BY path HAVING (argMax(change_type, last_time) != 2) AND (NOT match(path, '(^dbms/)|(^libs/)|(^tests/testflows/)|(^programs/server/store/)')) ORDER BY path ASC
SELECT path, max(time) AS last_time, argMax(change_type, time) AS change_type FROM git_clickhouse.file_changes GROUP BY path
SELECT path, max(time) AS last_time, argMax(change_type, time) AS change_type FROM git_clickhouse.file_changes GROUP BY path LIMIT 100
SELECT path, max(time) AS last_time, groupArray(time) as times, argMax(change_type, time) AS change_type FROM git_clickhouse.file_changes GROUP BY path LIMIT 100
SELECT payment_type_, count(*) as cnt FROM trips GROUP by payment_type_
SELECT price FROM uk_price_paid WHERE type = 'semi-detached' GROUP BY price
SELECT radio , created, Max (created) From cell_towers Group by created, radio Order by Max (created) Desc
SELECT radio , created, Min (created) From cell_towers Group by created, radio Order by Min (created) Desc
SELECT radio FROM cell_towers WHERE (lat < 56) and (lat > 54) and (lon < 56) and (lon > 54) and created = updated GROUP by radio
SELECT radio FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon > 54 AND lon < 56 AND lat > 54 AND created = updated GROUP BY radio
SELECT radio FROM cell_towers WHERE lat > 54 AND lat < 56 AND lon > 54 AND lon < 56
SELECT radio FROM cell_towers WHERE lat > 60 GROUP BY radio
SELECT radio FROM cell_towers WHERE lat >= 67
SELECT radio FROM cell_towers WHERE lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56
SELECT radio FROM cell_towers WHERE lon >= 54 AND lon <= 56 AND lat >= 54 AND lat <= 56 AND created = updated
SELECT radio FROM cell_towers WHERE lon >= 54 AND lon <= 56 AND lat >= 54 AND lat <= 56 AND created = updated GROUP BY radio
SELECT radio FROM cell_towers WHERE lon BETWEEN 54 AND 56 AND lat BETWEEN 54 AND 56 GROUP BY radio
SELECT radio FROM cell_towers WHERE mcc = '250' AND area = '30440' AND cell = '1041'
SELECT radio FROM cell_towers WHERE mcc = 250 AND area = 30440 AND cell = 1041
SELECT radio FROM cell_towers WHERE mcc = 724 GROUP by radio
SELECT radio FROM cell_towers WHERE mcc=250 and area=30440 and cell=1041
SELECT radio FROM cell_towers WHERE updated = created
SELECT radio From cell_towers WHERE lat BETWEEN '54' AND '56' AND lon BETWEEN '54' AND '56' Group by radio
SELECT radio, AVG (samples), MIN (created), MAX (created), MIN (updated), MAX (updated) From cell_towers WHERE lat BETWEEN '54' AND '56' AND lon BETWEEN '54' AND '56' GROUP BY radio
SELECT radio, AVG(samples) FROM cell_towers GROUP BY radio ORDER BY AVG(samples) DESC
SELECT radio, AVG(samples) FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon > 54 AND lon < 56 AND lat > 54 GROUP BY radio ORDER BY AVG(samples) DESC
SELECT radio, AVG(samples) FROM cell_towers WHERE lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56 GROUP BY radio
SELECT radio, AVG(samples) FROM cell_towers WHERE lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56 GROUP BY radio ORDER BY AVG(samples) DESC
SELECT radio, AVG(samples) FROM cell_towers WHERE lon >= 54 AND lon <= 56 AND lat >= 54 AND lat <= 56 GROUP BY radio
SELECT radio, AVG(samples) FROM cell_towers WHERE lon BETWEEN 54 AND 56 AND lat BETWEEN 54 AND 56 GROUP BY radio
SELECT radio, AVG(samples), MIN(created), MAX(created), MIN(updated), max(updated) FROM cell_towers WHERE lat >= 54 and lat <=56 and lon >= 54 and lon <= 56 GROUP BY radio
SELECT radio, COUNT (radio) FROM cell_towers WHERE lat > 67 GROUP BY radio
SELECT radio, COUNT (radio) FROM cell_towers WHERE lon BETWEEN 54 AND 56 AND lat BETWEEN 54 AND 56 GROUP BY radio ORDER BY COUNT (radio) DESC
SELECT radio, COUNT(radio) FROM cell_towers GROUP BY radio ORDER BY COUNT(radio) DESC
SELECT radio, COUNT(radio) FROM cell_towers WHERE lat > 0 AND 54 < lat < 56 AND lon > 0 AND 54 < lon < 56 AND radio ='GSM' GROUP BY radio
SELECT radio, COUNT(radio) FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon > 54 AND lon < 56 AND lat > 54 GROUP BY radio
SELECT radio, COUNT(radio) FROM cell_towers WHERE lat >= 67 GROUP BY radio
SELECT radio, COUNT(radio) FROM cell_towers WHERE lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56 GROUP BY radio
SELECT radio, COUNT(radio) FROM cell_towers WHERE lat >=54 AND lat <= 56 AND lon >=54 AND lon <= 56 GROUP BY radio ORDER BY COUNT(radio) DESC
SELECT radio, COUNT(radio) FROM cell_towers WHERE lat BETWEEN '54' AND '56' AND lon BETWEEN '54' AND '56' Group by radio
SELECT radio, COUNT(radio) FROM cell_towers WHERE lat>'67' GROUP BY radio ORDER BY COUNT(radio) DESC
SELECT radio, COUNT(radio) FROM cell_towers WHERE lon >= 54 AND lon <= 56 AND lat >= 54 AND lat <= 56 GROUP BY radio
SELECT radio, COUNT(radio) FROM cell_towers WHERE radio = 'GSM' AND lat >= 54 AND lat <= 56 AND lon >= 54 AND lon <= 56 GROUP BY radio
SELECT radio, COUNT(radio) FROM cell_towers WHERE radio= 'GSM' AND lat BETWEEN '54' AND '56' AND lon BETWEEN '54' AND '56' Group by radio
SELECT radio, COUNT(radio) FROM cell_towers WHERE radio= 'GSM' AND lat>'0' AND lon>'0' Group by radio
SELECT radio, COUNT(samples) FROM cell_towers WHERE created > '2017-01-01' GROUP BY radio ORDER BY COUNT(samples) DESC
SELECT radio, COUNT(samples) FROM cell_towers WHERE lon BETWEEN 54 AND 56 AND lat BETWEEN 54 AND 56 GROUP BY radio
SELECT radio, Count (radio) From cell_towers Where lat> '0' and lon > '0' Group by radio Order by Count (radio) Desc
SELECT radio, Count (radio) From cell_towers Where lat> '0' and lon > '0' and radio ='GSM' Group by radio Order by Count (radio) Desc
SELECT radio, Count (radio) From cell_towers Where lat> 67 Group by radio Order by Count (radio) Desc
SELECT radio, Count (radio),lat,lon From cell_towers Where '54'<lat<'56' and '54' <lon<'56' and radio = 'GSM' Group by radio,lat,lon Order by Count (radio) Desc
SELECT radio, Count (radio),lat,lon From cell_towers Where '54'<lat>'56' and '54' <lon>'56' and radio = 'GSM' Group by radio,lat,lon Order by Count (radio) Desc
SELECT radio, Count (radio),lat,lon From cell_towers Where '54'<lat>'56' and '54'<lon>'56' Group by radio,lat,lon Order by Count (radio) Desc
SELECT radio, Count (radio),lat,lon From cell_towers Where '54'>lat>'56' and '54' >lon>'56' and radio = 'GSM' Group by radio,lat,lon Order by Count (radio) Desc
SELECT radio, Count (radio),lat,lon From cell_towers Where lat> 0 and lon> 0 Group by radio,lat,lon Order by Count (radio) Desc
SELECT radio, Count (radio),lat,lon From cell_towers Where lat> 0 and lon> 0 and radio = 'GSM' Group by radio,lat,lon Order by Count (radio) Desc
SELECT radio, Count (radio),lat,lon From cell_towers Where lat>'0' and lon>'0' and radio = 'GSM' Group by radio,lat,lon Order by Count (radio) desc
SELECT radio, MAX(created) FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon > 54 AND lon < 56 AND lat > 54 GROUP BY radio ORDER BY MAX(created) DESC
SELECT radio, MAX(created) FROM cell_towers WHERE lat between 54 AND 56 AND lon between 54 AND 56 GROUP by radio
SELECT radio, MAX(created) FROM cell_towers WHERE lon >= 54 AND lon <= 56 AND lat >= 54 AND lat <= 56 GROUP BY radio
SELECT radio, MAX(lat) FROM cell_towers GROUP BY radio ORDER BY MAX(lat)
SELECT radio, MAX(lat) FROM cell_towers GROUP BY radio ORDER BY MAX(lat) DESC
SELECT radio, MAX(lat) FROM cell_towers GROUP by radio order by MAX(lat)
SELECT radio, MAX(samples) FROM cell_towers GROUP BY radio ORDER BY MAX(samples)
SELECT radio, MAX(samples) FROM cell_towers GROUP BY radio having created > 2017-01-01
SELECT radio, MAX(samples) FROM cell_towers WHERE created > 2017-01-01 AND radio = 'LTE' GROUP BY radio
SELECT radio, MAX(samples) FROM cell_towers WHERE created > 2017-01-01 GROUP BY radio
SELECT radio, MAX(samples) FROM cell_towers WHERE radio = 'LTE' AND created > '2017-01-01' GROUP BY radio ORDER BY MAX(samples)
SELECT radio, MAX(samples) FROM cell_towers WHERE radio = 'LTE' AND created > '2017-01-01' GROUP BY radio ORDER BY MAX(samples) DESC
SELECT radio, MIN(created) FROM cell_towers WHERE lat between 54 AND 56 AND lon between 54 AND 56 GROUP by radio
SELECT radio, MIN(created) FROM cell_towers WHERE lon >= 54 AND lon <= 56 AND lat >= 54 AND lat <= 56 GROUP BY radio
SELECT radio, MIN(created), MAX(created) FROM cell_towers WHERE lon BETWEEN 54 AND 56 AND lat BETWEEN 54 AND 56 GROUP BY radio
SELECT radio, area FROM cell_towers LIMIT 100
SELECT radio, area, cell FROM cell_towers LIMIT 100
SELECT radio, avg(samples) FROM cell_towers GROUP by radio
SELECT radio, avg(samples) FROM cell_towers GROUP by radio order by avg(samples)
SELECT radio, avg(samples) FROM cell_towers GROUP by radio order by avg(samples) desc
SELECT radio, avg(samples) FROM cell_towers WHERE (lat < 56) and (lat > 54) and (lon < 56) and (lon > 54) GROUP by radio order by avg(samples) desc
SELECT radio, avg(samples) as avg FROM cell_towers GROUP by radio Order by avg DESC
SELECT radio, avg(samples) as avg FROM cell_towers WHERE lat between 54 AND 56 AND lon between 54 AND 56 GROUP by radio Order by avg DESC
SELECT radio, count (radio),lat,lon From cell_towers Where lat>'0' and lon>'0' and radio = 'GSM' Group by radio,lat,lon Order by count (radio) desc
SELECT radio, count() AS c FROM cell_towers GROUP BY radio ORDER BY c
SELECT radio, count() AS c FROM cell_towers GROUP BY radio ORDER BY c DESC
SELECT radio, count() FROM cell_towers GROUP BY radio
SELECT radio, count() FROM cell_towers WHERE lat >= 54 and lat <=56 and lon >= 54 and lon <= 56 GROUP BY radio
SELECT radio, count() FROM cell_towers WHERE mcc = 724 GROUP by radio
SELECT radio, count(cell) FROM cell_towers WHERE lon > 54 and lon < 56 and lat > 54 and lat < 56 GROUP by radio order by uniqExact(cell) desc
SELECT radio, count(radio) FROM cell_towers WHERE lat > '67' GROUP by radio
SELECT radio, count(radio) FROM cell_towers WHERE lat > 54 and lat < 56 and lon > 54 and lon < 56 GROUP BY radio ORDER BY count(radio) DESC
SELECT radio, count(radio) FROM cell_towers WHERE lat between 54 AND 56 AND lon between 54 AND 56 GROUP by radio
SELECT radio, count(radio) FROM cell_towers WHERE lat between 54 AND 56 GROUP by radio
SELECT radio, created FROM cell_towers ORDER BY created ASC
SELECT radio, created FROM cell_towers ORDER BY created DESC
SELECT radio, created, MAX (samples) FROM cell_towers WHERE created > 01/01/2017 GROUP BY radio,samples, created ORDER BY MAX (samples) DESC
SELECT radio, created, MAX (samples) FROM cell_towers WHERE created >'2017-01-01 00:00:00' AND radio='LTE' GROUP BY radio,samples, created ORDER BY MAX (samples) DESC
SELECT radio, created, MAX (samples) FROM cell_towers WHERE created >'2017-01-01 00:00:00' GROUP BY radio,samples, created ORDER BY MAX (samples) DESC
SELECT radio, created, MAX (samples) FROM cell_towers WHERE radio='LTE' AND created > 01/01/2017 GROUP BY radio,samples, created ORDER BY MAX (samples) DESC
SELECT radio, created, samples FROM cell_towers
SELECT radio, created, updated FROM cell_towers WHERE (lat < 56) and (lat > 54) and (lon < 56) and (lon > 54) and created = updated GROUP by radio, created, updated
SELECT radio, created, updated FROM cell_towers WHERE lon BETWEEN 54 AND 56 AND lat BETWEEN 54 AND 56 AND created = updated
SELECT radio, created, updated, lat, lon FROM cell_towers WHERE lat between 54 AND 56 AND lon between 54 AND 56 AND created = updated
SELECT radio, created, updated, lon, lat FROM cell_towers WHERE lat BETWEEN 54 AND 56 AND lon BETWEEN 54 AND 56 AND created = updated
SELECT radio, lat FROM cell_towers
SELECT radio, lat FROM cell_towers WHERE lat > '67'
SELECT radio, lat FROM cell_towers WHERE lat>'67'
SELECT radio, max(created) FROM cell_towers WHERE (lat < 56) and (lat > 54) and (lon < 56) and (lon > 54) GROUP by radio order by max(created) desc
SELECT radio, min(created) FROM cell_towers WHERE (lat < 56) and (lat > 54) and (lon < 56) and (lon > 54) GROUP by radio order by min(created) desc
SELECT radio, min(created) FROM cell_towers WHERE lat between 54 AND 56 AND lon between 54 AND 56 GROUP by radio
SELECT radio, samples FROM cell_towers Where radio = 'LTE' AND created > 2017/01/01
SELECT radio, samples FROM cell_towers Where radio = 'LTE' AND created > 2017/01/01 GROUP BY samples, radio ORDER BY COUNT(samples) ASC
SELECT radio, samples FROM cell_towers Where radio = 'LTE' AND created > 2017/01/01 GROUP BY samples, radio ORDER BY COUNT(samples) DESC
SELECT radio, samples, Max (samples) From cell_towers Where radio='LTE' and created > '2017-01-01' Group by samples, radio Order by Max (samples) Desc
SELECT radio, samples, created FROM cell_towers WHERE created > '2017-01-01'
SELECT radio, samples, created FROM cell_towers WHERE created > '2017-01-01' AND radio = 'LTE'
SELECT radio, samples, created FROM cell_towers WHERE created > '2017-01-01' AND radio = 'LTE' ORDER BY samples DESC
SELECT radio, samples, created FROM cell_towers WHERE created > 2017-01-01
SELECT radio, sum (radio),lat,lon From cell_towers Where lat>'0' and lon>'0' and radio='GSM' Group by radio,lat,lon Order by sum (radio) Desc
SELECT radio, uniqIf(samples, samples > 1) FROM cell_towers GROUP by radio
SELECT radio,COUNT(radio) FROM cell_towers WHERE lat > 0 AND lon > 0 GROUP BY radio
SELECT radio,MIN(created) FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon > 54 AND lon < 56 AND lat > 54 GROUP BY radio ORDER BY MIN(created) DESC
SELECT radio,count(),sum(lon>0) x,sum(lon<=0) y,x+y=count() FROM cell_towers GROUP by radio order by count()desc LIMIT 100
SELECT radio,count(),sum(lon>0) x,sum(lon<=0) y,x+y=count() FROM cell_towers WHERE radio='LTE' GROUP by radio order by count()desc LIMIT 100
SELECT radio,lat,lon, COUNT(radio = 'GSM') FROM cell_towers WHERE lat > 0 AND lon > 0 GROUP BY radio,lat,lon ORDER BY lat, lon
SELECT radio,lat,lon, COUNT(radio) FROM cell_towers WHERE lat > 0 AND 54 < lat < 56 AND lon > 0 AND 54 < lon < 56 AND radio ='GSM' GROUP BY radio,lat,lon
SELECT radio,lat,lon, COUNT(radio) FROM cell_towers WHERE lat > 0 AND 54 < lat < 56 AND lon > 0 AND 54 < lon < 56 AND radio ='GSM' GROUP BY radio,lat,lon ORDER BY lat DESC,lon DESC
SELECT radio,lat,lon, COUNT(radio) FROM cell_towers WHERE lat > 0 AND 54 < lat < 56 AND lon > 0 AND 54 < lon < 56 AND radio ='GSM' GROUP BY radio,lat,lon ORDER BY lat, lon
SELECT radio,lat,lon, COUNT(radio) FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon < 56 AND radio ='GSM' GROUP BY radio,lat,lon ORDER BY lat DESC,lon DESC
SELECT radio,lat,lon, COUNT(radio) FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon > 54 AND lon < 56 AND lat > 54 GROUP BY radio,lat,lon ORDER BY lat DESC,lon DESC
SELECT radio,lat,lon, COUNT(radio) FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon > 54 AND lon < 56 GROUP BY radio,lat,lon ORDER BY lat DESC,lon DESC
SELECT radio,lat,lon, COUNT(radio) FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon > 54 AND radio ='GSM' GROUP BY radio,lat,lon ORDER BY lat DESC,lon DESC
SELECT radio,lat,lon, COUNT(radio) FROM cell_towers WHERE lat > 0 AND lat < 56 AND lon > 0 AND lon > 54 GROUP BY radio,lat,lon ORDER BY lat DESC,lon DESC
SELECT radio,lat,lon, COUNT(radio) FROM cell_towers WHERE lat > 0 AND lat > 54 AND lon > 0 AND lon < 56 AND radio ='GSM' GROUP BY radio,lat,lon ORDER BY lat, lon
SELECT radio,lat,lon, COUNT(radio) FROM cell_towers WHERE lat > 0 AND lat > 54 AND lon > 0 AND lon > 54 AND radio ='GSM' GROUP BY radio,lat,lon ORDER BY lat, lon
SELECT radio,lat,lon, COUNT(radio) FROM cell_towers WHERE lat > 0 AND lat > 54 AND lon > 0 AND radio ='GSM' GROUP BY radio,lat,lon ORDER BY lat, lon
SELECT radio,lat,lon, COUNT(radio) FROM cell_towers WHERE lat > 0 AND lon > 0 AND radio ='GSM' GROUP BY radio,lat,lon ORDER BY lat, lon
SELECT radio,lat,lon, COUNT(radio) FROM cell_towers WHERE lat > 0 AND lon > 0 GROUP BY radio,lat,lon ORDER BY lat, lon
SELECT repo AS name, groupArrayInsertAt(toUInt32(c), toUInt64(dateDiff('month', toDate('2015-01-01'), month))) AS data FROM ( SELECT lower(repo_name) AS repo, toStartOfMonth(created_at) AS month, count() AS c FROM github_events WHERE (event_type = 'WatchEvent') AND (toYear(created_at) >= 2015) AND (repo IN ( SELECT lower(repo_name) AS repo FROM github_events WHERE (event_type = 'WatchEvent') AND (toYear(created_at) >= 2015) GROUP BY repo ORDER BY count() DESC LIMIT 10 )) GROUP BY repo, month ) GROUP BY repo ORDER BY repo ASC
SELECT repo_name FROM ( SELECT repo_name, count() AS stars FROM github_events WHERE event_type = 'WatchEvent'GROUP BY repo_name ) WHERE stars > 1000
SELECT repo_name FROM github_events ORDER BY repo_name DESC LIMIT 50
SELECT repo_name FROM github_events WHERE event_type = 'WatchEvent' ORDER BY rand() LIMIT 50
SELECT repo_name FROM github_events WHERE startsWith(repo_name, 'substack') = 1 ORDER BY repo_name DESC LIMIT 50
SELECT repo_name FROM github_events WHERE startsWith(repo_name, 'substack/') AND repo_name LIKE '%date%' GROUP BY repo_name ORDER BY repo_name ASC LIMIT 50
SELECT repo_name FROM github_events WHERE startsWith(repo_name, 'substack/') GROUP BY repo_name ORDER BY repo_name ASC LIMIT 50
SELECT repo_name FROM github_events WHERE startsWith(repo_name, 'substack/') GROUP BY repo_name ORDER BY repo_name DESC LIMIT 50
SELECT repo_name, arrayJoin(labels) AS label, count() AS c FROM github_events WHERE (event_type IN ('CreateEvent', 'PullRequestEvent')) AND (action IN ('created', 'opened', 'labeled')) AND ((label ILIKE '%python%')) GROUP BY repo_name, label ORDER BY c DESC LIMIT 50
SELECT repo_name, arrayJoin(labels) AS label, count() AS c FROM github_events WHERE (event_type IN ('PullRequestEvent')) AND (action IN ('created', 'opened', 'labeled')) AND ((label ILIKE '%python%')) GROUP BY repo_name, label ORDER BY c DESC LIMIT 50
SELECT repo_name, count() AS comments, uniq(number) AS issues, round(comments / issues, 2) AS ratio FROM github_events WHERE event_type = 'IssueCommentEvent' GROUP BY repo_name ORDER BY count() DESC LIMIT 50
SELECT repo_name, count() AS stars FROM github_events WHERE event_type = 'WatchEvent' AND toYear(created_at) = '2020' GROUP BY repo_name ORDER BY stars DESC LIMIT 50
SELECT repo_name, count() AS stars FROM github_events WHERE event_type = 'WatchEvent' GROUP BY repo_name ORDER BY stars DESC LIMIT 50
SELECT repo_name, count() AS stars FROM github_events WHERE repo_name like '%golang%' GROUP BY repo_name ORDER BY stars DESC LIMIT 50
SELECT repo_name, count(repo_name) FROM github_events WHERE event_type = 'IssuesEvent' and (repo_name = 'leo-yuriev/libmdbx' or repo_name = 'erthink/libmdbx') GROUP BY repo_name ORDER BY repo_name ASC
SELECT repo_name, event_type FROM github_events WHERE startsWith(repo_name, 'substack/') AND repo_name LIKE '%parse-messy-time%' ORDER BY created_at ASC LIMIT 50
SELECT repo_name, event_type FROM github_events WHERE startsWith(repo_name, 'substack/') AND repo_name LIKE '%parse-messy-time%' ORDER BY repo_name ASC LIMIT 50
SELECT repo_name, event_type, created_at FROM github_events WHERE startsWith(repo_name, 'substack/') AND repo_name LIKE '%parse-messy-time%' ORDER BY created_at ASC LIMIT 50
SELECT repo_name, event_type, created_at FROM github_events WHERE startsWith(repo_name, 'substack/') AND repo_name LIKE '%parse-messy-time%' ORDER BY repo_name ASC LIMIT 50
SELECT repo_name, event_type, created_at, action FROM github_events WHERE startsWith(repo_name, 'substack/') AND repo_name LIKE '%parse-messy-time%' ORDER BY created_at ASC LIMIT 50
SELECT repo_name, groupUniqArray(path) as paths, groupUniqArray(base_ref) as refs FROM github_events WHERE path LIKE '%package.json' AND (event_type = 'PullRequestReviewCommentEvent' OR event_type = 'CommitCommentEvent') GROUP BY repo_name LIMIT 10000 OFFSET 0
SELECT repo_name, stars FROM ( SELECT repo_name, count() AS stars FROM github_events WHERE event_type = 'WatchEvent'GROUP BY repo_name order by stars desc ) WHERE stars > 1000
SELECT repo_name, sum(c) as clabel FROM ( SELECT * FROM ( SELECT repo_name, count() AS stars FROM github_events WHERE event_type = 'WatchEvent' GROUP BY repo_name HAVING stars <=200 ) AS t1 INNER JOIN ( SELECT repo_name, arrayJoin(labels) AS label, count() AS c FROM github_events WHERE (event_type IN ('CreateEvent', 'CommitCommentEvent', 'PullRequestEvent', 'IssuesEvent')) AND (action IN ('created', 'opened', 'labeled')) AND ((label ILIKE '%python%')) GROUP BY repo_name, label ORDER BY c DESC ) AS t2 USING (repo_name) ) GROUP BY repo_name ORDER BY clabel DESC
SELECT repo_name, sum(event_type = 'MemberEvent') AS invitations, sum(event_type = 'WatchEvent') AS stars FROM github_events WHERE event_type IN ('MemberEvent', 'WatchEvent') AND repo_name = 'koppi/iso-country-flags-svg-collection' GROUP BY repo_name HAVING stars >= 100 ORDER BY invitations DESC LIMIT 50
SELECT repo_name, sum(event_type = 'MemberEvent') AS invitations, sum(event_type = 'WatchEvent') AS stars FROM github_events WHERE event_type IN ('MemberEvent', 'WatchEvent') GROUP BY repo_name HAVING stars >= 100 ORDER BY invitations DESC LIMIT 50
SELECT repo_name, toDate(created_at) AS day, count() AS stars FROM github_events WHERE event_type = 'WatchEvent' GROUP BY repo_name, day ORDER BY count() DESC LIMIT 1 BY repo_name LIMIT 50
SELECT repo_name, toString(event_type) AS event_type, actor_login, created_at, toString(action) AS action, number, merged_at FROM github_events WHERE repo_name = 'apache/pulsar' AND multiMatchAny(event_type, ['PullRequestEvent' , 'PullRequestReviewCommentEvent' , 'PullRequestReviewEvent' , 'IssueCommentEvent']) AND actor_login NOT IN ('github-actions[bot]' , 'codecov-commenter') AND number = 9276
SELECT repo_name, uniq(actor_login) as people_reached_recently FROM github_events AS gh RIGHT OUTER JOIN (SELECT repo_name FROM github_events WHERE path LIKE '%package.json' AND (event_type = 'PullRequestReviewCommentEvent' OR event_type = 'CommitCommentEvent') GROUP BY repo_name) filteringt ON gh.repo_name = filteringt.repo_name WHERE created_at >= subtractMonths(now(), 3) GROUP BY repo_name ORDER BY people_reached_recently DESC LIMIT 10000 OFFSET 0
SELECT resort_name, total_snow / 1000 AS total_snow_m, resort_location, month_year FROM ( SELECT resort_name, highest_snow.station_id, geoDistance(lon, lat, station_location.1, station_location.2) / 1000 AS distance_km, highest_snow.total_snow, station_location, month_year, (lon, lat) AS resort_location FROM ( SELECT sum(snowfall) AS total_snow, station_id, any(location) AS station_location, month_year, substring(station_id, 1, 2) AS code FROM blogs.noaa WHERE (date > '2017-01-01') AND (code = 'US') AND (elevation > 1800) GROUP BY station_id, toYYYYMM(date) AS month_year ORDER BY total_snow DESC LIMIT 1000 ) AS highest_snow INNER JOIN blogs.resorts ON highest_snow.code = resorts.code WHERE distance_km < 20 ORDER BY resort_name ASC, total_snow DESC LIMIT 1 BY resort_name, station_id ) ORDER BY total_snow DESC LIMIT 5
SELECT resort_name, total_snow / 1000 AS total_snow_m, resort_location, month_year FROM ( SELECT resort_name, highest_snow.station_id, geoDistance(resorts_dict.lon, resorts_dict.lat, station_lon, station_lat) / 1000 AS distance_km, highest_snow.total_snow, (resorts_dict.lon, resorts_dict.lat) as resort_location, month_year FROM ( SELECT sum(snowfall) AS total_snow, station_id, dictGet(blogs.stations_dict, 'lat', station_id) AS station_lat, dictGet(blogs.stations_dict, 'lon', station_id) AS station_lon, month_year, dictGet(blogs.stations_dict, 'state', station_id) AS state FROM blogs.noaa WHERE (date > '2017-01-01') AND (state != '') AND (elevation > 1800) GROUP BY station_id, toYYYYMM(date) AS month_year ORDER BY total_snow DESC LIMIT 1000 ) AS highest_snow INNER JOIN blogs.resorts_dict ON highest_snow.state = resorts_dict.state WHERE distance_km < 20 ORDER BY resort_name ASC, total_snow DESC LIMIT 1 BY resort_name, station_id ) ORDER BY total_snow DESC LIMIT 5
SELECT reverse(NER) FROM recipes LIMIT 10
SELECT round(avg(tip_amount), 2) FROM trips
SELECT round(toUInt32OrZero(extract(menu_date, '^\d{4}')), -1) AS d, count(), round(avg(price), 2), bar(avg(price), 0, 100, 100) FROM menu_item_denorm WHERE (menu_currency = 'Dollars') AND (d > 0) AND (d < 2022) GROUP BY d ORDER BY d ASC
SELECT round(toUInt32OrZero(extract(menu_date, '^\d{4}')), -1) AS d, count(), round(avg(price), 2), bar(avg(price), 0, 50, 100) FROM menu_item_denorm WHERE (menu_currency = 'Dollars') AND (d > 0) AND (d < 2022) AND (dish_name ILIKE '%burger%') GROUP BY d ORDER BY d ASC
SELECT round(toUInt32OrZero(extract(menu_date, '^\d{4}')), -1) AS d, count(), round(avg(price), 2), bar(avg(price), 0, 50, 100) FROM menu_item_denorm WHERE (menu_currency IN ('Dollars', '')) AND (d > 0) AND (d < 2022) AND (dish_name ILIKE '%vodka%') GROUP BY d ORDER BY d ASC
SELECT round(toUInt32OrZero(extract(menu_date, '^d{4}')), -1) AS d, count(), round(avg(price), 2), bar(avg(price), 0, 50, 100), any(dish_name) FROM menu_item_denorm WHERE (menu_currency IN ('Dollars', '')) AND (d > 0) AND (d < 2022) AND (dish_name ILIKE '%caviar%') GROUP BY d ORDER BY d ASC LIMIT 1000000000
SELECT run_id,count(1) FROM benchmark_results GROUP by run_id
SELECT samples FROM cell_towers Where radio = 'LTE' AND created > 2017/01/01
SELECT samples From cell_towers
SELECT samples, AVG (samples), radio From cell_towers Group by radio, samples Order by Avg (samples) desc
SELECT samples, COUNT(samples) FROM cell_towers WHERE created > '2017-01-01' AND radio = 'LTE' GROUP BY samples ORDER BY COUNT(samples) DESC
SELECT samples, COUNT(samples) FROM cell_towers WHERE created >= '2020-06-01' AND radio = 'LTE' GROUP BY samples ORDER BY COUNT(samples) DESC
SELECT samples, COUNT(samples) FROM cell_towers WHERE created >= '2020-06-01' GROUP BY samples ORDER BY COUNT(samples) DESC
SELECT samples, COUNT(samples) FROM cell_towers WHERE radio = 'LTE' AND created > 2017-01-01 GROUP BY samples ORDER BY COUNT(samples) DESC
SELECT samples, MAX (samples) FROM cell_towers GROUP BY samples ORDER BY MAX (samples) DESC
SELECT samples, MAX (samples) FROM cell_towers WHERE created > 01/01/2017 GROUP BY samples ORDER BY MAX (samples) DESC
SELECT samples, MAX (samples) FROM cell_towers WHERE radio='LTE' AND created < 01/01/2017 GROUP BY samples ORDER BY MAX (samples) DESC
SELECT samples, MAX (samples) FROM cell_towers WHERE radio='LTE' AND created > 01/01/2017 GROUP BY samples ORDER BY MAX (samples) DESC
SELECT samples, MAX (samples) FROM cell_towers WHERE radio='LTE' GROUP BY samples ORDER BY MAX (samples) DESC
SELECT samples, MAX (samples) FROM cell_towers Where radio = 'LTE' AND created > 2017/01/01 GROUP BY samples
SELECT samples, radio FROM cell_towers Where radio = 'LTE' AND created > 2017/01/01
SELECT samples, radio, MAX (samples) FROM cell_towers Where created > 2017/01/01 AND radio='LTE' GROUP BY samples,radio
SELECT samples, radio, MAX (samples) FROM cell_towers Where created > 2017/01/01 AND radio='LTE' GROUP BY samples,radio ORDER BY (samples) ASC
SELECT samples, radio, MAX (samples) FROM cell_towers Where created > 2017/01/01 AND radio='LTE' GROUP BY samples,radio ORDER BY (samples) DESC
SELECT samples, radio, MAX (samples) FROM cell_towers Where created > 2017/01/01 GROUP BY samples,radio
SELECT sparkbar(9,toDate('2020-01-01'),toDate('2020-01-10'))(created_date,score) FROM reddit
SELECT sparkbar(9,toDate('2020-01-01'),toDate(2021-01-01))(created_date,score) FROM reddit
SELECT station_id FROM blogs.stations WHERE country_code = 'PO'
SELECT substringUTF8(toString(EventTime),1,10),count(*) as count FROM hits GROUP by substringUTF8(toString(EventTime),1,10)
SELECT sum(IsMobile) FROM hits
SELECT sum(JavaEnable), count() FROM hits_100m_compatible WHERE RegionID = 839 GROUP by RegionID , OS with totals
SELECT sum(LO_DISCOUNT) FROM lineorder
SELECT sum(UserAgent) OVER (partition by UserID) as sum_user_agent FROM (SELECT max(RegionID) as maxRegionID, CounterID FROM hits GROUP by CounterID) as a inner join hits_100m_compatible on hits_100m_compatible.CounterID = a.CounterID and hits_100m_compatible.RegionID = a.maxRegionID
SELECT sum(dish_count) FROM menu
SELECT sum(dish_count) FROM menu WHERE event = 'LUNCH'
SELECT sum(dish_count) FROM menu WHERE event = 'LUNCH' or event = 'DINNER'
SELECT sum(if(price>500,1,0)) as pd FROM stock WHERE symbol='WPO'
SELECT sum(new_confirmed) FROM covid GROUP by toYYYYMM(date)
SELECT sum(old_value),sum(new_value) FROM query_metrics_v2 LIMIT 10
SELECT sumIf(new_confirmed, date > '2020-01-01' and date <'2020-12-31'), date FROM covid GROUP by date
SELECT sumIf(new_confirmed, date > '2020-01-01' and date <'2020-12-31'), sumIf(new_deceased, date > '2020-01-01' and date <'2020-12-31'), sumIf(new_recovered, date > '2020-01-01' and date <'2020-12-31'), sumIf(new_tested, date > '2020-01-01' and date <'2020-12-31'), date FROM covid GROUP by date
SELECT symbol, avg(price) as avg_price FROM stock GROUP by symbol order by avg(price) desc LIMIT 5
SELECT symbol, avg(price) as avg_price FROM stock GROUP by symbol order by avg(price) desc LIMIT 5 offset 5
SELECT symbol, avg(price) as avg_price FROM stock WHERE price>500 GROUP by symbol LIMIT 5
SELECT symbol, avg(price) as avg_price FROM stock WHERE symbol='WPO' GROUP by symbol
SELECT symbol, sum(if(price>500,1,0)) as pd FROM stock WHERE symbol='WPO' GROUP by symbol
SELECT symbol,avg(price) as avg_price FROM stock GROUP by symbol LIMIT 5
SELECT t.* FROM blogs.countries t LIMIT 501
SELECT t.* FROM blogs.noaa t LIMIT 501
SELECT t.* FROM default.reddit t LIMIT 501
SELECT t.* FROM git_clickhouse.commits t LIMIT 501
SELECT t.* FROM git_clickhouse.file_changes t LIMIT 501
SELECT t0.* FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, arrayJoin(`NER`) AS `NER` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, `NER` FROM default.`recipes` ) t2 ) t0 WHERE lower(t0.`NER`) = 'saltpeter' LIMIT 500
SELECT t0.`NER_lower`, t0.`count`, t0.`percent` FROM ( SELECT * FROM ( SELECT *, (`count` * 100) / sum(`count`) OVER (ORDER BY Null) AS `percent` FROM ( SELECT lower(`NER`) AS `NER_lower`, count(lower(`NER`)) AS `count` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, `NER`, lower(`NER`) AS `NER_lower` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, arrayJoin(`NER`) AS `NER` FROM ( SELECT `title`, `ingredients`, `directions`, `link`, `source`, `NER` FROM default.`recipes` ) t6 ) t5 ) t4 GROUP BY `NER_lower` ) t3 ) t2 ORDER BY `count` DESC ) t0 WHERE match(t0.`NER_lower`, 'salt') LIMIT 500
SELECT tempMax / 10 AS maxTemp, station_id, date, (dictGet(blogs.stations_dict, 'lat', station_id), dictGet(blogs.stations_dict, 'lon', station_id)) AS location, dictGet(blogs.stations_dict, 'name', station_id) AS name FROM blogs.noaa WHERE dictGet(blogs.stations_dict, 'country_code', station_id) = 'PO' ORDER BY tempMax DESC LIMIT 5
SELECT tempMax / 10 AS maxTemp, station_id, date, (dictGet(blogs.stations_dict, 'lat', station_id), dictGet(blogs.stations_dict, 'lon', station_id)) AS location, dictGet(blogs.stations_dict, 'name', station_id) AS name FROM blogs.noaa WHERE station_id IN ( SELECT station_id FROM blogs.stations WHERE country_code = 'PO' ) ORDER BY tempMax DESC LIMIT 5
SELECT tempMax / 10 AS maxTemp, station_id, date, location FROM blogs.noaa WHERE station_id IN ( SELECT station_id FROM blogs.stations WHERE country_code = 'PO' ) ORDER BY tempMax DESC LIMIT 5
SELECT tempMax / 10 AS maxTemp, station_id, date, location FROM blogs.noaa WHERE station_id IN ( SELECT station_id FROM blogs.stations WHERE dictGet(blogs.stations_dict, 'country_code', station_id) = 'PO' ) ORDER BY tempMax DESC LIMIT 5
SELECT tempMax / 10 AS maxTemp, station_id, date, location FROM blogs.noaa WHERE substring(station_id, 1, 2) = 'PO' ORDER BY tempMax DESC LIMIT 5
SELECT tempMax / 10 AS maxTemp, station_id, date, location, name FROM blogs.noaa WHERE station_id IN ( SELECT station_id FROM blogs.stations WHERE country_code = 'PO' ) ORDER BY tempMax DESC LIMIT 5
SELECT tempMax / 10 AS maxTemp, station_id, date, stations.name AS name, (stations.lat, stations.lon) AS location FROM blogs.noaa INNER JOIN blogs.stations ON noaa.station_id = stations.station_id WHERE stations.country_code = 'PO' ORDER BY tempMax DESC LIMIT 5
SELECT tempMax / 10 AS maxTemp, station_id, date, stations_dict.name AS name, (blogs.stations_dict.lat, blogs.stations_dict.lon) AS location FROM blogs.noaa INNER JOIN blogs.stations_dict ON blogs.noaa.station_id = stations_dict.station_id WHERE country_code = 'PO' ORDER BY tempMax DESC LIMIT 5
SELECT tempMax / 10 AS maxTemp, station_id, date, stations_dict.name AS name, (blogs.stations_dict.lat, blogs.stations_dict.lon) AS location FROM blogs.noaa INNER JOIN blogs.stations_dict ON blogs.noaa.station_id = stations_dict.station_id WHERE dictGet(blogs.stations_dict, 'country_code', station_id) = 'PO' ORDER BY tempMax DESC LIMIT 5
SELECT tempMax / 10 AS maxTemp, station_id, date, stations_dict.name AS name, (blogs.stations_dict.lat, blogs.stations_dict.lon) AS location FROM blogs.noaa INNER JOIN blogs.stations_dict ON blogs.noaa.station_id = stations_dict.station_id WHERE stations_dict.country_code = 'PO' ORDER BY tempMax DESC LIMIT 5
SELECT time, project , subproject , hits , path FROM wikistat LIMIT 10
SELECT time, project , subproject , hits , path FROM wikistat WHERE 1 LIMIT 10
SELECT time, project , subproject , hits , path FROM wikistat WHERE path LIKE 'micka%' LIMIT 10
SELECT time, project , subproject , hits , path FROM wikistat WHERE path LIKE 'youri%' LIMIT 100000, 10
SELECT time, score, descendants, title, url, 'https://news.ycombinator.com/item?id=' || toString(id) AS hn_url FROM hackernews WHERE type = 'story' AND title ILIKE '%ClickHouse%' ORDER BY score DESC
SELECT time, substring(commit_hash, 1, 11) AS commit, change_type, author, path, old_path, lines_added, lines_deleted, commit_message FROM git_clickhouse.file_changes WHERE path = 'src/Storages/StorageReplicatedMergeTree.cpp' ORDER BY time DESC LIMIT 10
SELECT title, arrayJoin(directions) FROM recipes WHERE title = 'Shuku Shuku'
SELECT title, directions, NER FROM recipes WHERE title = 'Shuku Shuku'
SELECT title, ingredients, directions, NER FROM recipes WHERE title = 'Shuku Shuku'
SELECT title, ingredients, directions, link, source, NER FROM recipes LIMIT 50
SELECT title, length(NER) FROM recipes WHERE has(NER,'coconut')
SELECT title, length(NER) as n, length(directions) as d FROM recipes WHERE has(NER, 'strawberry') order by d desc LIMIT 10
SELECT title, length(NER), NER FROM recipes WHERE has(NER,'coconut')
SELECT title, length(NER), length(directions) FROM recipes WHERE has(NER, 'coconut') AND has(NER, 'flour') ORDER BY length(NER), length(directions)
SELECT title, length(NER), length(directions) FROM recipes WHERE has(NER, 'strawberry') ORDER BY length(directions) DESC LIMIT 10
SELECT title, length(NER), length(directions) FROM recipes WHERE has(NER,'coconut') AND has(NER,'flour') ORDER BY length(directions),length(NER) ASC
SELECT title, length(NER), length(directions) FROM recipes WHERE has(NER,'coconut') AND has(NER,'flour') ORDER by length(NER),length(directions)
SELECT toDate('2022-03-01') as start, * FROM blogs.country_codes LIMIT 10
SELECT toDate(EventTime) as timeLabel, count(*) as total,'0' as type FROM hits GROUP by timeLabel order by timeLabel
SELECT toDate(EventTime) as timeLabel, count(*) as total,'0' as type FROM hits GROUP by timeLabel order by timeLabel LIMIT 10
SELECT toDate(EventTime) as timeLabel, count(*) as total,'0' as type FROM hits GROUP by timeLabel order by timeLabel UNION all SELECT toDate(EventTime) as timeLabel, count(*) as total,'0' as type FROM hits GROUP by timeLabel order by timeLabel union all SELECT toDate(EventTime) as timeLabel, count(*) as total,'0' as type FROM hits GROUP by timeLabel order by timeLabel
SELECT toDate(EventTime) as timeLabel, count(*) as total,'0' as type FROM hits GROUP by timeLabel order by timeLabel union all SELECT toDate(EventTime) as timeLabel, count(*) as total,'0' as type FROM hits GROUP by timeLabel order by timeLabel
SELECT toDate(EventTime) as timeLabel, count(*) as total,'0' as type FROM hits GROUP by timeLabel order by timeLabel union all SELECT toDate(EventTime) as timeLabel, count(*) as total,'0' as type FROM hits GROUP by timeLabel order by timeLabel union all SELECT toDate(EventTime) as timeLabel, count(*) as total,'0' as type FROM hits GROUP by timeLabel order by timeLabel
SELECT toDate(EventTime) as timeLabel, count(*) as total,'0' as type FROM hits WHERE EventTime >= '2022-11-30' and EventTime <= '2022-11-30' GROUP by timeLabel order by timeLabel
SELECT toDate(EventTime) as timeLabel, count(*) as total,'0' as type FROM hits WHERE EventTime >= '2022-11-30' and EventTime <= '2022-11-30' GROUP by timeLabel order by timeLabel union all SELECT toDate(EventTime) as timeLabel, count(*) as total,'0' as type FROM hits WHERE EventTime >= '2022-11-30' and EventTime <= '2022-11-30' GROUP by timeLabel order by timeLabel
SELECT toDate(EventTime),count(*) as count FROM hits GROUP by toDate(EventTime)
SELECT toDate(`default`.`hits_100m_obfuscated`.`EventDate`) AS `EventDate`, count(*) AS `count`, count(distinct `default`.`hits_100m_obfuscated`.`UserID`) AS `count_2` FROM `default`.`hits_100m_obfuscated` WHERE (`default`.`hits_100m_obfuscated`.`EventDate` >= parseDateTimeBestEffort('2013-07-15 00:00:00') AND `default`.`hits_100m_obfuscated`.`EventDate` < parseDateTimeBestEffort('2013-07-29 00:00:00')) GROUP BY toDate(`default`.`hits_100m_obfuscated`.`EventDate`) ORDER BY toDate(`default`.`hits_100m_obfuscated`.`EventDate`) ASC LIMIT 1000
SELECT toDayOfWeek(file_time) weeks,count(comment_id) num FROM github_events WHERE file_time>='2022-11-01 00:00:00' GROUP by weeks
SELECT toMonday(day) AS k, count() AS c, bar(c, 0, 10000, 100) AS bar FROM opensky WHERE origin IN ('UUEE', 'UUDD', 'UUWW') GROUP BY k ORDER BY k ASC
SELECT toStartOfDay(time, 'Europe/Amsterdam')::INT AS t, sum(hits)::INT AS v FROM wikistat WHERE path = 'ClickHouse' GROUP BY t ORDER BY t
SELECT toStartOfDay(toDateTime(`created_at`)) AS `__timestamp`, `event_type` AS `event_type`, COUNT(*) AS `count` FROM `default`.`github_events` GROUP BY `event_type`, toStartOfDay(toDateTime(`created_at`)) ORDER BY `count` DESC LIMIT 10000
SELECT toStartOfDay(toDateTime(`date`)) AS `__timestamp`, min(`count`) AS `MIN(count)` FROM (SELECT toStartOfMonth(created_at) as date, count() as count FROM github_events WHERE date < toStartOfMonth(now()) GROUP by date order by date) AS `virtual_table` GROUP BY toStartOfDay(toDateTime(`date`)) ORDER BY `MIN(count)` DESC LIMIT 1000
SELECT toStartOfDay(toDateTime(date)) AS `__timestamp`, count(`count`) AS `COUNT(count)` FROM (SELECT toStartOfMonth(created_at) as date, count() as count FROM github_events WHERE date < toStartOfMonth(now()) GROUP by date order by date) AS `virtual_table` GROUP BY toStartOfDay(toDateTime(date)) ORDER BY `COUNT(count)` DESC LIMIT 1000
SELECT toStartOfDay(toDateTime(date)) AS `__timestamp`, min(`count`) AS `MIN(count)` FROM (SELECT toStartOfMonth(created_at) as date, SUM (commits) as count FROM `default`.`github_events` GROUP by date order by date) AS `virtual_table` GROUP BY toStartOfDay(toDateTime(date)) ORDER BY `MIN(count)` DESC LIMIT 100
SELECT toStartOfDay(toDateTime(date)) AS `__timestamp`, min(`count`) AS `MIN(count)` FROM (SELECT toStartOfMonth(created_at) as date, count() as count FROM github_events WHERE date < toStartOfMonth(now()) GROUP by date order by date) AS `virtual_table` GROUP BY toStartOfDay(toDateTime(date)) ORDER BY `MIN(count)` DESC LIMIT 1000
SELECT toStartOfHour(EventTime) as hour, RegionID FROM hits GROUP by toStartOfHour(EventTime), RegionID
SELECT toStartOfMonth(created_at) AS t FROM github_events WHERE startsWith(repo_name, 'apache/pulsar') AND actor_login <> 'github-actions[bot]' GROUP BY t LIMIT 5000
SELECT toStartOfMonth(created_at) AS t FROM github_events WHERE startsWith(repo_name, 'apache/pulsar') AND actor_login <> 'github-actions[bot]' GROUP BY t ORDER BY t DESC LIMIT 5000
SELECT toStartOfMonth(created_at) as date, SUM (commits) as count FROM `default`.`github_events` GROUP by date order by date LIMIT 1001
SELECT toStartOfMonth(created_at) as date, count() as count FROM github_events WHERE date < toStartOfMonth(now()) GROUP by date order by date
SELECT toStartOfMonth(created_at) as date, count() as count FROM github_events WHERE date < toStartOfMonth(now()) GROUP by date order by date LIMIT 1001
SELECT toStartOfMonth(created_at) as date, count() as count FROM github_events WHERE date <= toStartOfMonth(now()) GROUP by date order by date
SELECT toStartOfMonth(created_at) as date, count() as count FROM github_events WHERE date >= '2015-01-01' GROUP by date order by date
SELECT toStartOfMonth(created_at) as date, count() as count FROM github_events WHERE date >= '2015-01-01' and date <= toStartOfMonth(now()) GROUP by date order by date
SELECT toStartOfMonth(d) AS month, median(u) FROM (SELECT CAST(time, 'Date') AS d, uniq(author) AS u FROM git_clickhouse.commits GROUP BY d ORDER BY d ASC) GROUP BY month ORDER BY month ASC
SELECT toStartOfMonth(d) AS month, median(u) FROM (SELECT time::Date AS d, uniq(author) AS u FROM git_clickhouse.commits GROUP BY d ORDER BY d) GROUP BY month ORDER BY month
SELECT toStartOfMonth(d) AS month, median(u), arrayExists(x -> lower(x) == 'vdimir' or lower(x) == 'vladimir c', flatten(groupUniqArray(a))), (flatten(groupUniqArray(a))) FROM ( SELECT time::Date AS d, uniq(author) AS u, groupUniqArray(author) as a FROM git_clickhouse.commits GROUP BY d ORDER BY d) GROUP BY month ORDER BY month
SELECT toStartOfMonth(d) AS month, median(u), arrayExists(x -> lower(x) == 'vdimir', flatten(groupUniqArray(a))) FROM ( SELECT time::Date AS d, uniq(author) AS u, groupUniqArray(author) as a FROM git_clickhouse.commits GROUP BY d ORDER BY d) GROUP BY month ORDER BY month
SELECT toStartOfMonth(d) AS month, median(u), arrayExists(x -> lower(x) == 'vdimir', flatten(groupUniqArray(a))), (flatten(groupUniqArray(a))) FROM ( SELECT time::Date AS d, uniq(author) AS u, groupUniqArray(author) as a FROM git_clickhouse.commits GROUP BY d ORDER BY d) GROUP BY month ORDER BY month
SELECT toStartOfMonth(d) AS month, median(u), arrayExists(x -> lower(x) == 'vdimir', flatten(groupUniqArray(a))), arrayUniq(flatten(groupUniqArray(a))) FROM ( SELECT time::Date AS d, uniq(author) AS u, groupUniqArray(author) as a FROM git_clickhouse.commits GROUP BY d ORDER BY d) GROUP BY month ORDER BY month
SELECT toStartOfMonth(d) AS month, median(u), flatten(groupUniqArray(a)) FROM ( SELECT time::Date AS d, uniq(author) AS u, groupUniqArray(author) as a FROM git_clickhouse.commits GROUP BY d ORDER BY d) GROUP BY month ORDER BY month
SELECT toStartOfMonth(d) AS month, median(u), groupArray(a) FROM ( SELECT time::Date AS d, uniq(author) AS u, groupArray(author) as a FROM git_clickhouse.commits GROUP BY d ORDER BY d) GROUP BY month ORDER BY month
SELECT toStartOfMonth(d) AS month, median(u), groupArray(u) FROM (SELECT time::Date AS d, uniq(author) AS u FROM git_clickhouse.commits GROUP BY d ORDER BY d) GROUP BY month ORDER BY month
SELECT toStartOfMonth(d) AS month, median(u), groupArray(u) FROM (SELECT time::Date AS d, uniq(author) AS u, groupArray(author) FROM git_clickhouse.commits GROUP BY d ORDER BY d) GROUP BY month ORDER BY month
SELECT toStartOfMonth(d) AS month, median(u), groupArray(x) FROM (SELECT time::Date AS d, uniq(author) AS u, groupArray(author) as x FROM git_clickhouse.commits GROUP BY d ORDER BY d) GROUP BY month ORDER BY month
SELECT toStartOfMonth(d) AS month, median(u), groupUniqArray(a) FROM ( SELECT time::Date AS d, uniq(author) AS u, groupUniqArray(author) as a FROM git_clickhouse.commits GROUP BY d ORDER BY d) GROUP BY month ORDER BY month
SELECT toStartOfMonth(d) AS month, median(u), groupUniqArray(x) FROM (SELECT time::Date AS d, uniq(author) AS u, groupUniqArray(author) as x FROM git_clickhouse.commits GROUP BY d ORDER BY d) GROUP BY month ORDER BY month
SELECT toStartOfWeek(file_time) weeks,action ac,author_association author, number nu,count(1) num FROM github_events WHERE file_time>='2022-11-01 00:00:00' GROUP by weeks,action,number,author_association order by weeks asc
SELECT toStartOfWeek(file_time) weeks,action ac,author_association author, number nu,count(1) num,sum(if(changed_files>1000,1,0)) hc,sum(if(changed_files<=1000,1,0)) lc FROM github_events WHERE file_time>='2022-11-01 00:00:00' GROUP by weeks,action,number,author_association order by weeks asc
SELECT toStartOfWeek(file_time) weeks,action ac,author_association author,count(1) num FROM github_events WHERE file_time>='2022-11-01 00:00:00' GROUP by weeks,action,author_association order by weeks asc
SELECT toStartOfWeek(file_time) weeks,action ac,count(1) num FROM github_events WHERE file_time>='2022-11-01 00:00:00' GROUP by weeks,action
SELECT toStartOfWeek(file_time) weeks,action ac,count(1) num FROM github_events WHERE file_time>='2022-11-01 00:00:00' GROUP by weeks,action order by weeks asc
SELECT toStartOfWeek(file_time) weeks,action ac,count(1) num,count(if(changed_files>1000,1,0)) c FROM github_events WHERE file_time>='2022-11-01 00:00:00' GROUP by weeks,action order by weeks asc
SELECT toStartOfWeek(file_time) weeks,action ac,count(1) num,sum(if(changed_files>1000,1,0)) hc,sum(if(changed_files<=1000,1,0)) lc FROM github_events WHERE file_time>='2022-11-01 00:00:00' GROUP by weeks,action order by weeks asc
SELECT toStartOfWeek(file_time) weeks,action ac,count(1) num,sum(if(changed_files>10000,1,0)) c FROM github_events WHERE file_time>='2022-11-01 00:00:00' GROUP by weeks,action order by weeks asc
SELECT toStartOfWeek(file_time) weeks,count(1) num FROM github_events WHERE file_time>='2022-11-01 00:00:00' GROUP by weeks
SELECT toStartOfWeek(file_time) weeks,count(comment_id) num FROM github_events WHERE file_time>='2022-11-01 00:00:00' GROUP by weeks
SELECT toString(event_type) FROM github_events LIMIT 10
SELECT toTypeName(event_type) FROM github_events
SELECT toYear(FlightDate) AS year, count(*) AS Total, countIf(funnel_level > 0) AS CHI_tot, countIf(funnel_level = 2) AS ATL_tot FROM ( SELECT FlightDate, IATA_CODE_Reporting_Airline, Tail_Number, windowFunnel(86400)(toUInt32(ArrTime), Dest IN ('MDW', 'ORD'), Dest = 'ATL') AS funnel_level FROM ontime WHERE DepTime < ArrTime AND Tail_Number != '' GROUP BY FlightDate, IATA_CODE_Reporting_Airline, Tail_Number ORDER BY FlightDate ASC, IATA_CODE_Reporting_Airline ASC, Tail_Number ASC ) GROUP BY year ORDER BY year ASC
SELECT toYear(FlightDate) AS year, count(*) AS Total, sum(CHI_Arr != 0) AS CHI_tot, sum(ATL_Arr != 0) AS ATL_tot FROM ( SELECT FlightDate, IATA_CODE_Reporting_Airline, Tail_Number, arraySort(groupArray(ArrTime)) AS Arrivals, arraySort((x, y) -> y, groupArray(Dest), groupArray(ArrTime)) AS Dests, arrayFilter((arr, dest) -> (dest in ('MDW', 'ORD')), Arrivals, Dests)[1] as CHI_Arr, arrayFilter((arr, dest) -> (dest = 'ATL' AND arr > CHI_Arr And CHI_Arr != 0), Arrivals, Dests)[1] as ATL_Arr FROM ontime WHERE DepTime < ArrTime AND Tail_Number != '' GROUP BY FlightDate, IATA_CODE_Reporting_Airline, Tail_Number ORDER BY FlightDate, IATA_CODE_Reporting_Airline, Tail_Number ) GROUP BY year ORDER By year
SELECT toYear(created_at) AS year, count() AS stars, bar(stars, 0, 50000000, 10) AS bar FROM github_events WHERE event_type = 'WatchEvent' GROUP BY year ORDER BY year
SELECT toYear(date) AS year, round(avg(maxWindSpeed)) AS price, bar(price, 0, 1000000, 80 ) FROM blogs.noaa GROUP BY year ORDER BY year
SELECT toYear(date) AS year, round(avg(price)) AS price, bar(price, 0, 1000000, 80 ) FROM uk_price_paid GROUP BY 1 ORDER BY 1
SELECT toYear(date) AS year, round(avg(price)) AS price, bar(price, 0, 1000000, 80 ) FROM uk_price_paid GROUP BY year
SELECT toYear(date) AS year, round(avg(price)) AS price, bar(price, 0, 1000000, 80 ) FROM uk_price_paid GROUP BY year ORDER BY year desc
SELECT toYear(date) AS year, round(avg(tempMax)) AS price, bar(price, 0, 1000000, 80 ) FROM blogs.noaa GROUP BY year ORDER BY year
SELECT top 1 * FROM opensky
SELECT top 100 * FROM repos
SELECT town, count() AS c, round(avg(price)) AS price, bar(price, 0, 5000000, 100) FROM uk_price_paid WHERE date >= '2020-01-01' GROUP BY town, district HAVING c >= 100 ORDER BY price DESC LIMIT 100
SELECT town, district, count() AS c, avg(price) AS price, bar(price, 0, 5000000, 100) FROM uk_price_paid WHERE date >= '2020-01-01' GROUP BY town, district HAVING c >= 100 ORDER BY price DESC LIMIT 100
SELECT town, district, count() AS c, round(avg(price)) AS price, bar(price, 0, 5000000, 100) FROM uk_price_paid WHERE date <> '2020-01-01' GROUP BY town, district HAVING c >= 100 ORDER BY price DESC LIMIT 100
SELECT town, district, count() AS c, round(avg(price)) AS price, bar(price, 0, 5000000, 100) FROM uk_price_paid WHERE date >= '2020-01-01' and town == 'LONDON' GROUP BY town, district HAVING c >= 100 ORDER BY price DESC
SELECT town, district, count() AS c, round(avg(price)) AS price, bar(price, 0, 5000000, 100) FROM uk_price_paid WHERE toYear(date) >= 2020 GROUP BY town, district HAVING c >= 100 ORDER BY price DESC LIMIT 100
SELECT type FROM hackernews WHERE type = 'story'
SELECT uniq(actor_login) FROM github_events
SELECT uniq(path) FROM git_clickhouse.line_changes
SELECT uniq(repo_name) FROM github_events
SELECT uniq(repo_name) FROM github_events WHERE startsWith(repo_name, 'substack/') GROUP BY repo_name ORDER BY repo_name DESC LIMIT 50
SELECT x.* FROM `default`.cell_towers x
SELECT x.* FROM `default`.checks x
SELECT x.* FROM `default`.covid x
SELECT x.* FROM `default`.github_events x
SELECT x.* FROM `default`.hackernews x
SELECT x.* FROM `default`.reddit x
SELECT x.* FROM blogs.countries x
SELECT x.* FROM blogs.country_codes x
SELECT x.* FROM blogs.forex_2020s x
SELECT x.* FROM blogs.hackernews_json x
SELECT x.* FROM blogs.hackernews_json_v2 x
SELECT x.* FROM blogs.http_logs x
SELECT x.* FROM blogs.http_logs x ORDER BY x.`timestamp`
SELECT x.* FROM blogs.http_logs x ORDER BY x.`timestamp` DESC
SELECT x.* FROM blogs.noaa_v2 x
SELECT x.* FROM git_clickhouse.commits x
SELECT x.* FROM git_clickhouse.file_changes x
SELECT x.* FROM git_clickhouse.line_changes x
SELECT year(created_at) as y ,event_type,count() FROM github_events GROUP by y,event_type
SELECT year(created_at) as y,actor_login,count() FROM github_events GROUP by y,actor_login
SELECT year(created_at) as y,count() FROM github_events GROUP by y
SELECT year(created_at), count(1), event_type FROM github_events WHERE actor_login = 'Sorck' GROUP by year(created_at), event_type
SELECT year(created_at), count(1), event_type FROM github_events WHERE actor_login = 'Sorck' GROUP by year(created_at), event_type order by toYear(created_at) asc, event_type asc
SELECT year(created_at), count(1), event_type FROM github_events WHERE actor_login = 'Sorck' and created_at > '2018-01-01' GROUP by year(created_at), event_type order by toYear(created_at) asc, event_type asc
SELECT year(created_at), count(1), event_type FROM github_events WHERE actor_login = 'Sorck' and event_type = 'PullRequestEvent' GROUP by year(created_at), event_type order by toYear(created_at) asc, event_type asc
SELECT year, count() AS stars FROM github_events WHERE (event_type = 'WatchEvent') AND (repo_name = 'ClickHouse/ClickHouse') GROUP BY toYear(created_at) AS year ORDER BY stars DESC
SELECT year, lower(repo_name) AS repo, count() FROM github_events WHERE (event_type = 'WatchEvent') AND (year >= 2015) GROUP BY repo, toYear(created_at) AS year ORDER BY year ASC, count() DESC LIMIT 10 BY year
SELECT * FROM cell_towers
WITH '2022-08-01'::Date AS start_date SELECT actor_login, count() AS c, c >= dateDiff('week', start_date, today()) * 4 AS ok FROM default.github_events WHERE created_at >= start_date AND repo_name = 'ClickHouse/ClickHouse' AND event_type IN ('PullRequestEvent', 'PullRequestReviewEvent') AND ((event_type = 'PullRequestEvent' AND actor_login = assignee AND action = 'closed') OR (event_type = 'PullRequestReviewEvent' AND review_state = 'approved')) GROUP BY actor_login ORDER BY c DESC
WITH (SELECT count() FROM hits) as test SELECT sum(UserID)/test FROM hits
WITH (event_type = 'IssuesEvent') AND (action = 'opened') AS issue_created SELECT repo_name, sum(issue_created) AS c, uniqIf(actor_login, issue_created) AS u, sum(event_type = 'WatchEvent') AS stars FROM github_events WHERE event_type IN ('IssuesEvent', 'WatchEvent') GROUP BY repo_name ORDER BY u DESC LIMIT 50
WITH current_files AS ( SELECT path FROM ( SELECT old_path AS path, max(time) AS last_time, 2 AS change_type FROM git_clickhouse.file_changes GROUP BY old_path UNION ALL SELECT path, max(time) AS last_time, argMax(change_type, time) AS change_type FROM git_clickhouse.file_changes GROUP BY path ) GROUP BY path HAVING (argMax(change_type, last_time) != 2) AND (NOT match(path, '(^dbms/)|(^libs/)|(^tests/testflows/)|(^programs/server/store/)')) ORDER BY path ASC ) SELECT path, count() AS c FROM git_clickhouse.file_changes WHERE (author = 'Alexey Milovidov') AND (path IN (current_files)) GROUP BY path ORDER BY c DESC LIMIT 10
WITH dates AS (SELECT date, `sum(new_tested)` AS ru_test, `kz.sum(new_tested)` AS kz_test FROM (SELECT date, SUM(new_tested) FROM covid WHERE location_key = 'RU' GROUP BY date) AS ru JOIN (SELECT date, SUM(new_tested) FROM covid WHERE location_key = 'KZ' GROUP BY date) AS kz ON ru.date = kz.date ) SELECT * FROM dates
WITH histogram (5)(new_confirmed) as hist SELECT arrayJoin(hist).3 as confirmed, bar(confirmed, 0, 6, 5) as bar FROM (SELECT * FROM covid order by date)
WITH histogram (5)(new_confirmed) as hist SELECT arrayJoin(hist).3 as confirmed, bar(confirmed, 0, 6, 5) as bar FROM (SELECT * FROM covid)
WITH identity(_CAST(0, 'Nullable(UInt64)')) AS test SELECT sum(UserID)/test FROM hits
WITH repo_name IN ( SELECT repo_name FROM github_events WHERE (event_type = 'WatchEvent') AND (actor_login IN ('alexey-milovidov')) ) AS is_my_repo SELECT actor_login, sum(is_my_repo) AS stars_my, sum(NOT is_my_repo) AS stars_other, round(stars_my / (203 + stars_other), 3) AS ratio FROM github_events WHERE event_type = 'WatchEvent' GROUP BY actor_login ORDER BY ratio DESC LIMIT 50
WITH toDate('2022-03-01') as start SELECT * FROM blogs.country_codes LIMIT 10
WITH toDate('2022-03-01') as start SELECT subtractDays(toDate(start),10) as dd, * FROM blogs.country_codes LIMIT 10
WITH toYear(created_at) AS year SELECT repo_name, sum(year = 2020) AS stars2020, sum(year = 2019) AS stars2019, round(stars2020 / stars2019, 3) AS yoy, min(created_at) AS first_seen FROM github_events WHERE event_type = 'WatchEvent' GROUP BY repo_name HAVING (min(created_at) <= '2019-01-01 00:00:00') AND (stars2019 >= 1000) ORDER BY yoy DESC LIMIT 50

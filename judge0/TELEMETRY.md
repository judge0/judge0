# Telemetry
This document is for those who deploy Judge0 to their own infrastructure and not for those who consume Judge0.

If you just consume Judge0 then you should read the [privacy policy](PRIVACY_POLICY.md).

## Introduction
Since version v1.6.0 Judge0 is collecting telemetry data which is used to help understand how to improve the product and to better understand how Judge0 is used in various production environments.

Our close-source [telemetry client](bin/telemetry) periodically sends telemetry data to our central telemetry server.

Telemetry reporting is **enabled** by default.

This document describes how to disable telemetry reporting and what data is collected.

## Disabling Telemetry Reporting
To disable telemetry reporting set variable `JUDGE0_TELEMETRY_ENABLE` to `false` in [judge0.conf](judge0.conf).

## Collected Data
Every deployed instance of Judge0 with enabled telemetry reporting has its own ID that is used to identify the instance.

### The Data Telemetry Client Sends
Your instance of Judge0 will send the new telemetry report to our central telemetry server every 12 hours. Following data is send in the report:
- the ID of your instance and
- the version of your Judge0 instance

### The Data Telemetry Server Stores
When the new telemetry report arrives our telemetry server stores the following data:
- all the data that telemetry clients sends and
- timestamp when the report was send

IP address of your instance is **not** sent or stored.

Note that only the last report is stored on telemetry server, i.e. the new report overwrites the last report.

## Other Notes and Information
1. You can disable telemetry reporting at any time but the data from the last report stays stored on the telemetry server.
#!/bin/bash

# Get mgmt_ip from first argument or prompt for it
if [[ -n "$1" ]]; then
  mgmt_ip="$1"
else
  read -p "MGMT IP: " mgmt_ip
fi

user="aecid"
known_hosts="$HOME/.ssh/known_hosts"

# List of target hosts
hosts=(
  "$mgmt_ip"
  "10.0.0.10"
  "10.0.0.11"
  "10.0.0.20"
  "10.0.0.21"
  "10.0.0.22"
  "10.0.0.100"
  "10.0.0.101"
  "10.0.0.200"
)

echo "Testing SSH connections ..."

for host in "${hosts[@]}"; do
  if [[ "$host" == "$mgmt_ip" ]]; then
    ssh_cmd=(ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=accept-new "$user@$host" exit)
    scan_target="$host"
  else
    ssh_cmd=(ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=accept-new -J "$user@$mgmt_ip" "$user@$host" exit)
    scan_target="$host"
  fi

  # Run and capture stderr for error checking
  err_output=$("${ssh_cmd[@]}" 2>&1)
  status=$?

  if [[ $status -eq 0 ]]; then
    echo "[OK] SSH to $host"
    continue
  fi

  # Look for host key change warning in the stderr output
  if echo "$err_output" | grep -q "REMOTE HOST IDENTIFICATION HAS CHANGED"; then
    echo "[WARN] Host key mismatch for $host – removing old key ..."
    ssh-keygen -R "$scan_target" >/dev/null 2>&1

    # Try to fetch a fresh key
    echo "[INFO] Fetching new key for $host ..."
    ssh-keyscan -H "$scan_target" >> "$known_hosts" 2>/dev/null

    # Retry the connection
    err_output=$("${ssh_cmd[@]}" 2>&1)
    status=$?

    if [[ $status -eq 0 ]]; then
      echo "[OK] SSH to $host"
    else
      echo "[FAIL] SSH to $host"
      echo "$err_output"
    fi
  else
    echo "[FAIL] SSH to $host"
    echo "$err_output"
  fi
done

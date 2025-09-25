1. Attacker knows user/pass and logs into windows-system using WMI (T1047)
2. Attacker hides payload using process injection (T1055)
3. Attacker uses Mimikatz to dump credentials (T1003)
4. Attacker escalates privileges using:\
    a) win-tasks  (T1547)\
    b) logon scripts (T1037)\
    c) modify system process (T1543)
5. Attacker persists malware using:\
    a) BITS Jobs (T1197)\
    b) Autostart (T1547)\
    c) DLL-Hijacking (T1574)\
    d) Windows-Task (T1053) startet by Tracker.exe (T1127)
6. Attacker moves to domain controller using:\
    a) token manipulation (T1134) or pass-the-hash (T1550)\
    b) rouge domain controller (T1207)\
    c) Golden Ticket (T1649)\
    d) kerberroast (T1482)
7. Attacker modifies GPO (T1484) on domain-controller
8. Attacker uses NinjaCopy to read out data from volume (T1006)

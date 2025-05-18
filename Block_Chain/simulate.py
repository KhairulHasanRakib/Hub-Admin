import sys
sys.stdout.reconfigure(encoding='utf-8')

import uuid

class Transaction:
    def __init__(self, sender, receiver, amount):
        self.id = str(uuid.uuid4())  # ইউনিক ট্রান্স্যাকশন আইডি
        self.sender = sender
        self.receiver = receiver
        self.amount = amount

    def __str__(self):
        return f"{self.sender} ➜ {self.receiver} : {self.amount} BTC (ID: {self.id[:8]})"

class Ledger:
    def __init__(self):
        self.transactions = []

    def add_transaction(self, transaction):
        print(f"[+] Adding: {transaction}")
        self.transactions.append(transaction)

    def trace_funds(self, wallet):
        print(f"\n🔍 Tracing funds for wallet: {wallet}")
        history = []
        for tx in self.transactions:
            if tx.receiver == wallet or tx.sender == wallet:
                history.append(tx)
        return history

# ------------------------
# Simulation begins
# ------------------------

ledger = Ledger()

# Transactions
t1 = Transaction("Ali", "Rahim", 5)
t2 = Transaction("Rahim", "Suman", 5)
t3 = Transaction("Suman", "HackerWallet123", 5)

# Add to ledger
ledger.add_transaction(t1)
ledger.add_transaction(t2)
ledger.add_transaction(t3)

# Tracking Hacker Wallet
trace_result = ledger.trace_funds("HackerWallet123")
for tx in trace_result:
    print("🔗", tx)

# Optional: Trace backwards manually
print("\n🧬 Full backward trace:")
wallet = "HackerWallet123"
while True:
    found = False
    for tx in ledger.transactions:
        if tx.receiver == wallet:
            print("🔗", tx)
            wallet = tx.sender
            found = True
            break
    if not found:
        break

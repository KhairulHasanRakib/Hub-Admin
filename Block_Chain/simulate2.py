import sys
sys.stdout.reconfigure(encoding='utf-8')
import uuid
from collections import defaultdict

class Transaction:
    def __init__(self, sender, receiver, amount):
        self.id = str(uuid.uuid4())
        self.sender = sender
        self.receiver = receiver
        self.amount = amount

    def __str__(self):
        return f"{self.sender} -> {self.receiver} : {self.amount} BTC (ID: {self.id[:8]})"

class Ledger:
    def __init__(self):
        self.transactions = []

    def add_transaction(self, transaction):
        print(f"[+] Adding: {transaction}")
        self.transactions.append(transaction)

    def trace_funds(self, wallet):
        print(f"\n🔍 Tracing funds for wallet: {wallet}")
        trace_chain = []
        current_wallet = wallet

        for tx in reversed(self.transactions):
            if tx.receiver == current_wallet:
                trace_chain.append(tx)
                current_wallet = tx.sender

        print("\n🧬 Full backward trace:")
        for tx in trace_chain:
            print(f"🔗 {tx}")

    def calculate_balances(self):
        balances = defaultdict(float)
        for tx in self.transactions:
            balances[tx.sender] -= tx.amount
            balances[tx.receiver] += tx.amount
        return balances

    def print_balances(self):
        print("\n💰 Wallet Balances:")
        balances = self.calculate_balances()
        for wallet, balance in balances.items():
            print(f" - {wallet}: {balance} BTC")

# ==== DEMO ====
ledger = Ledger()

# Simulated Transactions
t1 = Transaction("Ali", "Rahim", 5)
t2 = Transaction("Rahim", "Suman", 5)
t3 = Transaction("Suman", "HackerWallet123", 5)

ledger.add_transaction(t1)
ledger.add_transaction(t2)
ledger.add_transaction(t3)

# Trace the funds
ledger.trace_funds("HackerWallet123")

# Show current balances
ledger.print_balances()

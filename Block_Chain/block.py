import hashlib
import time

# ব্লক ক্লাস
class Block:
    def __init__(self, index, data, prev_hash):
        self.index = index
        self.timestamp = time.time()
        self.data = data
        self.prev_hash = prev_hash
        self.hash = self.calculate_hash()

    def calculate_hash(self):
        block_string = f"{self.index}{self.timestamp}{self.data}{self.prev_hash}"
        return hashlib.sha256(block_string.encode()).hexdigest()

# Blockchain ক্লাস
class Blockchain:
    def __init__(self):
        self.chain = [self.create_genesis_block()]

    def create_genesis_block(self):
        return Block(0, "Genesis Block", "0")

    def get_latest_block(self):
        return self.chain[-1]

    def add_block(self, new_data):
        prev_block = self.get_latest_block()
        new_block = Block(len(self.chain), new_data, prev_block.hash)
        self.chain.append(new_block)

    def is_chain_valid(self):
        for i in range(1, len(self.chain)):
            curr = self.chain[i]
            prev = self.chain[i - 1]

            if curr.hash != curr.calculate_hash():
                return False

            if curr.prev_hash != prev.hash:
                return False

        return True

# ======= কোড চালানো =======

# Blockchain তৈরি
my_chain = Blockchain()

# ব্লক যোগ করা
# my_chain.add_block("আলি রাহিমকে ৫০ টাকা দিলো")
# my_chain.add_block("রাহিম সুমনকে ২০ টাকা দিলো")
my_chain.add_block("Ali sent 50 to Rahim")
my_chain.add_block("Rahim sent 20 to Suman")
my_chain.add_block("Suman sent 10 to Karim")

# চেইন যাচাই
print("Blockchain valid?", my_chain.is_chain_valid())

# সব ব্লক প্রিন্ট করা
for block in my_chain.chain:
    print(f"\nBlock {block.index}:")
    print("Data:", block.data)
    print("Hash:", block.hash)
    print("Prev Hash:", block.prev_hash)

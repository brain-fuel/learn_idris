// Token bucket. Lazy refill: we compute available tokens on each call from
// (now - lastUpdate) * refillPerSec, capped at capacity. No background timer.

export class TokenBucket {
  constructor(capacity, refillPerSec) {
    this.capacity     = capacity;
    this.refillPerSec = refillPerSec;
    this.tokens       = capacity;
    this.lastUpdate   = Date.now();
  }

  refill(now = Date.now()) {
    const elapsed = (now - this.lastUpdate) / 1000;
    this.tokens = Math.min(this.capacity, this.tokens + elapsed * this.refillPerSec);
    this.lastUpdate = now;
  }

  /**
   * consume(n): true if we had n tokens to spend, false if we dropped.
   */
  consume(n = 1) {
    this.refill();
    if (this.tokens < n) return false;
    this.tokens -= n;
    return true;
  }
}

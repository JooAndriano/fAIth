import { createRemoteJWKSet, jwtVerify } from 'jose';

const FIREBASE_JWKS_URL = new URL(
  'https://www.googleapis.com/service_accounts/v1/jwk/securetoken@system.gserviceaccount.com',
);

// Module scope: the key set is cached and reused across requests in the same isolate.
const jwks = createRemoteJWKSet(FIREBASE_JWKS_URL);

/** Extracts the token from an `Authorization: Bearer <token>` header, or null. */
export function bearerToken(header: string | null): string | null {
  if (!header) return null;
  const match = /^Bearer\s+(\S+)$/i.exec(header.trim());
  return match ? match[1] : null;
}

/**
 * Verifies a Firebase ID token (signature, issuer, audience, exp, sub) and returns its uid.
 * Throws on any failure.
 */
export async function verifyFirebaseIdToken(token: string, projectId: string): Promise<string> {
  const { payload } = await jwtVerify(token, jwks, {
    issuer: `https://securetoken.google.com/${projectId}`,
    audience: projectId,
    algorithms: ['RS256'],
    requiredClaims: ['exp', 'sub'],
  });
  if (typeof payload.sub !== 'string' || payload.sub.trim().length === 0) {
    throw new Error('missing sub');
  }
  return payload.sub;
}

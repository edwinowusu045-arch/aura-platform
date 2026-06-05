import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { z } from 'zod';

const jwtSecret = 'aura-secret-2026';

const registerSchema = z.object({
  type: z.literal('register'),
  name: z.string().min(2),
  email: z.string().email(),
  password: z.string().min(6),
  organization: z.string().min(2)
});

const loginSchema = z.object({
  type: z.literal('login'),
  email: z.string().email(),
  password: z.string().min(6)
});

const users: Record<string, { name: string; email: string; passwordHash: string; organization: string; role: 'user' | 'admin' }> = {
  'owusueddie1@gmail.com': {
    name: 'Eddie Owusu',
    email: 'owusueddie1@gmail.com',
    passwordHash: bcrypt.hashSync('pintogee12'),
    organization: 'AURA Executive',
    role: 'admin'
  }
};

export async function registerUser(data: unknown) {
  const parsed = registerSchema.safeParse(data);
  if (!parsed.success) {
    return { success: false, message: 'Invalid registration data' };
  }

  const { email, name, password, organization } = parsed.data;
  if (users[email]) {
    return { success: false, message: 'Account already exists' };
  }

  const passwordHash = await bcrypt.hash(password, 10);
  users[email] = { name, email, organization, passwordHash, role: 'user' };
  const token = jwt.sign({ email, role: 'user', name }, jwtSecret, { expiresIn: '30d' });

  return { success: true, token, user: { name, email, organization, role: 'user' } };
}

export async function authenticateUser(data: unknown) {
  const parsed = loginSchema.safeParse(data);
  if (!parsed.success) {
    return { success: false, message: 'Invalid login data' };
  }

  const { email, password } = parsed.data;
  const user = users[email];
  if (!user) {
    return { success: false, message: 'Invalid credentials' };
  }

  const matched = await bcrypt.compare(password, user.passwordHash);
  if (!matched) {
    return { success: false, message: 'Invalid credentials' };
  }

  const token = jwt.sign({ email: user.email, role: user.role, name: user.name }, jwtSecret, { expiresIn: '30d' });
  return { success: true, token, user: { name: user.name, email: user.email, organization: user.organization, role: user.role } };
}

export function verifyToken(token: string) {
  try {
    return jwt.verify(token, jwtSecret);
  } catch {
    return null;
  }
}

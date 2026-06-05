import { NextRequest, NextResponse } from 'next/server';
import { authenticateUser, registerUser } from '@aura/api';

export async function POST(request: NextRequest) {
  const body = await request.json();
  if (body.type === 'register') {
    const result = await registerUser(body);
    return NextResponse.json(result, { status: result.success ? 200 : 400 });
  }

  if (body.type === 'login') {
    const result = await authenticateUser(body);
    return NextResponse.json(result, { status: result.success ? 200 : 401 });
  }

  return NextResponse.json({ success: false, message: 'Invalid auth request' }, { status: 400 });
}

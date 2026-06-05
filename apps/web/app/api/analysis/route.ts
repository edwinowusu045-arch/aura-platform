import { NextResponse } from 'next/server';
import { createSimulatedAnalysis } from '@aura/api';

export async function GET() {
  return NextResponse.json({ success: true, analysis: createSimulatedAnalysis() });
}

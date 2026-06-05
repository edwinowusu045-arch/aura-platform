import { useEffect, useMemo, useState } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { Pressable, ScrollView, StatusBar, Text, TextInput, View } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import * as Notifications from 'expo-notifications';

const Stack = createNativeStackNavigator();

function Card({ children }: { children: React.ReactNode }) {
  return <View className="rounded-3xl bg-white p-6 shadow-card">{children}</View>;
}

function HomeScreen({ navigation }: any) {
  const [message, setMessage] = useState('Deliver premium confidence with AURA.');

  useEffect(() => {
    Notifications.scheduleNotificationAsync({
      content: { title: 'AURA Mobile', body: 'Your weekly analysis is ready.' },
      trigger: { seconds: 10 }
    });
  }, []);

  return (
    <ScrollView className="flex-1 bg-[#0A0A0A] p-6">
      <StatusBar style="light" />
      <Text className="mt-10 text-4xl font-semibold text-white">AURA Mobile</Text>
      <Text className="mt-4 text-lg leading-8 text-slate-300">Institutional AI intelligence for on-demand business confidence.</Text>
      <View className="mt-10 space-y-4">
        <Pressable onPress={() => navigation.navigate('Dashboard')} className="rounded-full bg-[#C9A96E] px-6 py-4">
          <Text className="text-center text-sm font-semibold uppercase text-[#0A0A0A]">Open Dashboard</Text>
        </Pressable>
        <Pressable onPress={() => navigation.navigate('Insights')} className="rounded-full border border-white/20 px-6 py-4">
          <Text className="text-center text-sm font-semibold text-white">View Insights</Text>
        </Pressable>
        <Pressable onPress={() => navigation.navigate('Launchpad')} className="rounded-full border border-[#C9A96E] px-6 py-4">
          <Text className="text-center text-sm font-semibold text-[#C9A96E]">Run Launchpad</Text>
        </Pressable>
      </View>
      <Card>
        <Text className="text-sm uppercase tracking-[0.3em] text-[#003399]">Live pulse</Text>
        <Text className="mt-3 text-3xl font-semibold text-[#0A0A0A]">{message}</Text>
        <Text className="mt-4 text-sm leading-7 text-[#4B5563]">Monitor plan signals, risk alerts and expert commentary in a single mobile view.</Text>
      </Card>
    </ScrollView>
  );
}

function DashboardScreen() {
  const [score] = useState(94);
  const cards = useMemo(
    () => [
      { label: 'Health Score', value: `${score}%` },
      { label: 'Analyses', value: '32 active' },
      { label: 'Forecast', value: '+18%' }
    ],
    [score]
  );

  return (
    <ScrollView className="flex-1 bg-[#F8F8F8] p-6">
      <Text className="text-3xl font-semibold text-[#0A0A0A]">Dashboard</Text>
      <Text className="mt-3 text-sm text-[#4B5563]">Investor and institution controls at your fingertips.</Text>
      <View className="mt-8 space-y-4">
        {cards.map((card) => (
          <Card key={card.label}>
            <Text className="text-sm uppercase tracking-[0.3em] text-[#003399]">{card.label}</Text>
            <Text className="mt-3 text-2xl font-semibold text-[#0A0A0A]">{card.value}</Text>
          </Card>
        ))}
      </View>
    </ScrollView>
  );
}

function InsightsScreen() {
  return (
    <ScrollView className="flex-1 bg-[#F8F8F8] p-6">
      <Text className="text-3xl font-semibold text-[#0A0A0A]">Insights</Text>
      <Text className="mt-3 text-sm text-[#4B5563]">Overview, revenue, risk and benchmark signals for your organization.</Text>
      <View className="mt-8 space-y-4">
        <Card>
          <Text className="text-sm uppercase tracking-[0.3em] text-[#003399]">Market outlook</Text>
          <Text className="mt-3 text-lg font-semibold text-[#0A0A0A]">Institutional trust continues to drive premium asset allocation.</Text>
        </Card>
        <Card>
          <Text className="text-sm uppercase tracking-[0.3em] text-[#003399]">Risk snapshot</Text>
          <Text className="mt-3 text-lg font-semibold text-[#0A0A0A]">Anomaly detection and compliance signals are stable.</Text>
        </Card>
      </View>
    </ScrollView>
  );
}

function LaunchpadScreen() {
  const [idea, setIdea] = useState('');
  const [score, setScore] = useState(78);

  return (
    <ScrollView className="flex-1 bg-[#F8F8F8] p-6">
      <Text className="text-3xl font-semibold text-[#0A0A0A]">Launchpad</Text>
      <Text className="mt-3 text-sm text-[#4B5563]">Submit a description and review confidence, strengths, gaps and recommendations.</Text>
      <View className="mt-8 space-y-4">
        <TextInput value={idea} onChangeText={setIdea} placeholder="Describe your pitch or idea" placeholderTextColor="#94A3B8" className="rounded-3xl border border-slate-300 bg-white px-4 py-4 text-base text-[#0A0A0A]" />
        <Pressable onPress={() => setScore((prev) => Math.min(100, prev + 3))} className="rounded-full bg-[#003399] px-6 py-4">
          <Text className="text-center text-sm font-semibold text-white">Evaluate confidence</Text>
        </Pressable>
        <Card>
          <Text className="text-sm uppercase tracking-[0.3em] text-[#003399]">Confidence score</Text>
          <Text className="mt-3 text-4xl font-semibold text-[#0A0A0A]">{score}%</Text>
        </Card>
      </View>
    </ScrollView>
  );
}

function PlansScreen() {
  const tiers = [
    { title: 'Lite', subtitle: 'Free, 1/mo', color: '#E8F1FF' },
    { title: 'Pro', subtitle: '$79/mo', color: '#0D1B5A' },
    { title: 'Enterprise+', subtitle: '$2,499/mo', color: '#C9A96E' }
  ];

  return (
    <ScrollView className="flex-1 bg-[#F8F8F8] p-6">
      <Text className="text-3xl font-semibold text-[#0A0A0A]">Plans</Text>
      <View className="mt-8 space-y-4">
        {tiers.map((tier) => (
          <View key={tier.title} className="rounded-3xl border border-slate-200 bg-white p-6">
            <Text className="text-xl font-semibold text-[#0A0A0A]">{tier.title}</Text>
            <Text className="mt-2 text-sm text-[#4B5563]">{tier.subtitle}</Text>
          </View>
        ))}
      </View>
    </ScrollView>
  );
}

function ProfileScreen() {
  return (
    <ScrollView className="flex-1 bg-[#F8F8F8] p-6">
      <Text className="text-3xl font-semibold text-[#0A0A0A]">Profile lenses</Text>
      <Text className="mt-3 text-sm text-[#4B5563]">Student, Financial Institution, Advisor and Investor views to keep your workspace aligned.</Text>
      <View className="mt-8 space-y-4">
        <Card>
          <Text className="text-lg font-semibold text-[#0A0A0A]">Student</Text>
          <Text className="mt-2 text-sm text-[#4B5563]">Study planner, flashcards, citation helper and academic integrity reminders.</Text>
        </Card>
        <Card>
          <Text className="text-lg font-semibold text-[#0A0A0A]">Financial Institution</Text>
          <Text className="mt-2 text-sm text-[#4B5563]">Regulatory scanner, stress test, fraud monitoring and SWIFT overview.</Text>
        </Card>
      </View>
    </ScrollView>
  );
}

export default function App() {
  useEffect(() => {
    Notifications.setNotificationHandler({
      handleNotification: async () => ({ shouldShowAlert: true, shouldPlaySound: false, shouldSetBadge: false })
    });
  }, []);

  return (
    <NavigationContainer>
      <Stack.Navigator screenOptions={{ headerStyle: { backgroundColor: '#0A0A0A' }, headerTintColor: '#FFFFFF' }}>
        <Stack.Screen name="Home" component={HomeScreen} options={{ title: 'AURA' }} />
        <Stack.Screen name="Dashboard" component={DashboardScreen} />
        <Stack.Screen name="Insights" component={InsightsScreen} />
        <Stack.Screen name="Launchpad" component={LaunchpadScreen} />
        <Stack.Screen name="Plans" component={PlansScreen} />
        <Stack.Screen name="Profile" component={ProfileScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

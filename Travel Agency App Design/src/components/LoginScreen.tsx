import { useState } from 'react';
import { Users, Building, UserCircle, Mail, Lock } from 'lucide-react';

interface LoginScreenProps {
  onLogin: (role: 'customer' | 'representative' | 'supplier', name: string) => void;
  onSwitchToRegister: () => void;
  isDarkMode: boolean;
}

type UserRole = 'customer' | 'representative' | 'supplier' | null;

export function LoginScreen({ onLogin, onSwitchToRegister, isDarkMode }: LoginScreenProps) {
  const [selectedRole, setSelectedRole] = useState<UserRole>(null);
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showSocialLogin, setShowSocialLogin] = useState(false);

  const handleRoleSelect = (role: UserRole) => {
    setSelectedRole(role);
    setShowSocialLogin(role === 'customer');
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (selectedRole) {
      const name = email.split('@')[0];
      onLogin(selectedRole, name.charAt(0).toUpperCase() + name.slice(1));
    }
  };

  const handleSocialLogin = (provider: string) => {
    onLogin('customer', 'John Doe');
  };

  if (!selectedRole) {
    return (
      <div className="min-h-screen flex items-center justify-center p-4">
        <div className="w-full max-w-5xl">
          {/* Logo and Title */}
          <div className="text-center mb-8 sm:mb-12">
            <div className="w-16 h-16 sm:w-20 sm:h-20 bg-gradient-to-br from-teal-500 to-orange-500 rounded-2xl flex items-center justify-center mx-auto mb-4 sm:mb-6 shadow-2xl">
              <span className="text-3xl sm:text-4xl">🌴</span>
            </div>
            <h1 className="text-3xl sm:text-4xl md:text-5xl text-gray-900 dark:text-white mb-2 sm:mb-4">
              Welcome to EgyptTravel
            </h1>
            <p className="text-base sm:text-lg text-gray-600 dark:text-gray-400 px-4">
              Choose your role to continue
            </p>
          </div>

          {/* Role Selection Cards */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 sm:gap-6 mb-6 sm:mb-8">
            {/* Customer Card */}
            <button
              onClick={() => handleRoleSelect('customer')}
              className="group relative bg-white dark:bg-gray-800 rounded-2xl p-6 sm:p-8 shadow-xl hover:shadow-2xl transition-all duration-300 hover:scale-105 border-2 border-transparent hover:border-teal-500"
            >
              <div className="absolute inset-0 bg-gradient-to-br from-teal-500/10 to-transparent rounded-2xl opacity-0 group-hover:opacity-100 transition-opacity"></div>
              <div className="relative">
                <div className="w-16 h-16 sm:w-20 sm:h-20 bg-gradient-to-br from-teal-400 to-teal-600 rounded-2xl flex items-center justify-center mx-auto mb-4 sm:mb-6 shadow-lg group-hover:shadow-xl transition-shadow">
                  <Users className="w-8 h-8 sm:w-10 sm:h-10 text-white" />
                </div>
                <h3 className="text-xl sm:text-2xl text-gray-900 dark:text-white mb-2 sm:mb-3">Customer</h3>
                <p className="text-sm sm:text-base text-gray-600 dark:text-gray-400 mb-4 sm:mb-6">
                  Book activities, experiences, and special events
                </p>
                <div className="text-teal-500 group-hover:text-teal-600 transition-colors">
                  Login as Customer →
                </div>
              </div>
            </button>

            {/* Representative Card */}
            <button
              onClick={() => handleRoleSelect('representative')}
              className="group relative bg-white dark:bg-gray-800 rounded-2xl p-6 sm:p-8 shadow-xl hover:shadow-2xl transition-all duration-300 hover:scale-105 border-2 border-transparent hover:border-orange-500"
            >
              <div className="absolute inset-0 bg-gradient-to-br from-orange-500/10 to-transparent rounded-2xl opacity-0 group-hover:opacity-100 transition-opacity"></div>
              <div className="relative">
                <div className="w-16 h-16 sm:w-20 sm:h-20 bg-gradient-to-br from-orange-400 to-orange-600 rounded-2xl flex items-center justify-center mx-auto mb-4 sm:mb-6 shadow-lg group-hover:shadow-xl transition-shadow">
                  <UserCircle className="w-8 h-8 sm:w-10 sm:h-10 text-white" />
                </div>
                <h3 className="text-xl sm:text-2xl text-gray-900 dark:text-white mb-2 sm:mb-3">Representative</h3>
                <p className="text-sm sm:text-base text-gray-600 dark:text-gray-400 mb-4 sm:mb-6">
                  Manage customer activities and bookings
                </p>
                <div className="text-orange-500 group-hover:text-orange-600 transition-colors">
                  Login as Representative →
                </div>
              </div>
            </button>

            {/* Supplier Card */}
            <button
              onClick={() => handleRoleSelect('supplier')}
              className="group relative bg-white dark:bg-gray-800 rounded-2xl p-6 sm:p-8 shadow-xl hover:shadow-2xl transition-all duration-300 hover:scale-105 border-2 border-transparent hover:border-purple-500"
            >
              <div className="absolute inset-0 bg-gradient-to-br from-purple-500/10 to-transparent rounded-2xl opacity-0 group-hover:opacity-100 transition-opacity"></div>
              <div className="relative">
                <div className="w-16 h-16 sm:w-20 sm:h-20 bg-gradient-to-br from-purple-400 to-purple-600 rounded-2xl flex items-center justify-center mx-auto mb-4 sm:mb-6 shadow-lg group-hover:shadow-xl transition-shadow">
                  <Building className="w-8 h-8 sm:w-10 sm:h-10 text-white" />
                </div>
                <h3 className="text-xl sm:text-2xl text-gray-900 dark:text-white mb-2 sm:mb-3">Supplier</h3>
                <p className="text-sm sm:text-base text-gray-600 dark:text-gray-400 mb-4 sm:mb-6">
                  Accept trip requests and manage bookings
                </p>
                <div className="text-purple-500 group-hover:text-purple-600 transition-colors">
                  Login as Supplier →
                </div>
              </div>
            </button>
          </div>

          {/* Register Link */}
          <div className="text-center">
            <p className="text-sm sm:text-base text-gray-600 dark:text-gray-400">
              Don't have an account?{' '}
              <button
                onClick={onSwitchToRegister}
                className="text-teal-600 dark:text-teal-400 hover:text-teal-700 dark:hover:text-teal-300 transition-colors"
              >
                Register Now
              </button>
            </p>
          </div>
        </div>
      </div>
    );
  }

  const getRoleColor = () => {
    switch (selectedRole) {
      case 'customer':
        return 'from-teal-500 to-teal-600';
      case 'representative':
        return 'from-orange-500 to-orange-600';
      case 'supplier':
        return 'from-purple-500 to-purple-600';
      default:
        return 'from-teal-500 to-teal-600';
    }
  };

  const getRoleIcon = () => {
    switch (selectedRole) {
      case 'customer':
        return <Users className="w-8 h-8 text-white" />;
      case 'representative':
        return <UserCircle className="w-8 h-8 text-white" />;
      case 'supplier':
        return <Building className="w-8 h-8 text-white" />;
      default:
        return <Users className="w-8 h-8 text-white" />;
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center p-4">
      <div className="w-full max-w-md">
        {/* Back Button */}
        <button
          onClick={() => setSelectedRole(null)}
          className="mb-6 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors flex items-center space-x-2"
        >
          <span>←</span>
          <span>Back to role selection</span>
        </button>

        {/* Login Card */}
        <div className="bg-white dark:bg-gray-800 rounded-2xl shadow-2xl p-6 sm:p-8">
          {/* Header */}
          <div className="text-center mb-6 sm:mb-8">
            <div className={`w-16 h-16 bg-gradient-to-br ${getRoleColor()} rounded-2xl flex items-center justify-center mx-auto mb-4 shadow-lg`}>
              {getRoleIcon()}
            </div>
            <h2 className="text-2xl sm:text-3xl text-gray-900 dark:text-white mb-2">
              Login as {selectedRole?.charAt(0).toUpperCase() + selectedRole?.slice(1)}
            </h2>
            <p className="text-sm sm:text-base text-gray-600 dark:text-gray-400">
              Enter your credentials to continue
            </p>
          </div>

          {/* Social Login for Customers */}
          {showSocialLogin && (
            <div className="space-y-3 mb-6">
              <button
                onClick={() => handleSocialLogin('google')}
                className="w-full bg-white dark:bg-gray-700 border-2 border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-200 py-3 rounded-xl hover:bg-gray-50 dark:hover:bg-gray-600 transition-all shadow-md hover:shadow-lg flex items-center justify-center space-x-3"
              >
                <span className="text-xl">🔍</span>
                <span>Continue with Google</span>
              </button>
              <button
                onClick={() => handleSocialLogin('apple')}
                className="w-full bg-black dark:bg-gray-900 text-white py-3 rounded-xl hover:bg-gray-800 transition-all shadow-md hover:shadow-lg flex items-center justify-center space-x-3"
              >
                <span className="text-xl">🍎</span>
                <span>Continue with Apple</span>
              </button>

              <div className="relative my-6">
                <div className="absolute inset-0 flex items-center">
                  <div className="w-full border-t border-gray-300 dark:border-gray-600"></div>
                </div>
                <div className="relative flex justify-center text-sm">
                  <span className="px-4 bg-white dark:bg-gray-800 text-gray-500 dark:text-gray-400">
                    Or continue with email
                  </span>
                </div>
              </div>
            </div>
          )}

          {/* Login Form */}
          <form onSubmit={handleSubmit} className="space-y-4 sm:space-y-5">
            <div>
              <label className="block text-sm text-gray-700 dark:text-gray-300 mb-2">
                Email Address
              </label>
              <div className="relative">
                <Mail className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
                <input
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="you@example.com"
                  required
                  className="w-full pl-11 pr-4 py-3 rounded-xl border-2 border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-gray-500 focus:ring-2 focus:ring-teal-500 focus:border-transparent transition-all"
                />
              </div>
            </div>

            <div>
              <label className="block text-sm text-gray-700 dark:text-gray-300 mb-2">
                Password
              </label>
              <div className="relative">
                <Lock className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
                <input
                  type="password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  placeholder="••••••••"
                  required
                  className="w-full pl-11 pr-4 py-3 rounded-xl border-2 border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-gray-500 focus:ring-2 focus:ring-teal-500 focus:border-transparent transition-all"
                />
              </div>
            </div>

            <div className="flex items-center justify-between text-sm">
              <label className="flex items-center space-x-2 cursor-pointer">
                <input
                  type="checkbox"
                  className="w-4 h-4 rounded border-gray-300 text-teal-500 focus:ring-teal-500"
                />
                <span className="text-gray-600 dark:text-gray-400">Remember me</span>
              </label>
              <button
                type="button"
                className="text-teal-600 dark:text-teal-400 hover:text-teal-700 dark:hover:text-teal-300 transition-colors"
              >
                Forgot password?
              </button>
            </div>

            <button
              type="submit"
              className={`w-full bg-gradient-to-r ${getRoleColor()} text-white py-3 rounded-xl hover:shadow-lg transition-all duration-300 transform hover:scale-105`}
            >
              Login
            </button>
          </form>

          {/* Register Link */}
          <div className="mt-6 text-center">
            <p className="text-sm text-gray-600 dark:text-gray-400">
              Don't have an account?{' '}
              <button
                onClick={onSwitchToRegister}
                className="text-teal-600 dark:text-teal-400 hover:text-teal-700 dark:hover:text-teal-300 transition-colors"
              >
                Register Now
              </button>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}

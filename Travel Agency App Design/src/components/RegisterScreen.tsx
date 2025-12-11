import { useState } from 'react';
import { Users, Building, UserCircle, Mail, Lock, User, Phone } from 'lucide-react';

interface RegisterScreenProps {
  onRegister: (role: 'customer' | 'representative' | 'supplier', name: string) => void;
  onSwitchToLogin: () => void;
  isDarkMode: boolean;
}

type UserRole = 'customer' | 'representative' | 'supplier' | null;

export function RegisterScreen({ onRegister, onSwitchToLogin, isDarkMode }: RegisterScreenProps) {
  const [selectedRole, setSelectedRole] = useState<UserRole>(null);
  const [formData, setFormData] = useState({
    fullName: '',
    email: '',
    phone: '',
    password: '',
    confirmPassword: '',
  });
  const [showSocialRegister, setShowSocialRegister] = useState(false);

  const handleRoleSelect = (role: UserRole) => {
    setSelectedRole(role);
    setShowSocialRegister(role === 'customer');
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (selectedRole && formData.password === formData.confirmPassword) {
      onRegister(selectedRole, formData.fullName);
    }
  };

  const handleSocialRegister = (provider: string) => {
    onRegister('customer', 'John Doe');
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
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
              Join EgyptTravel
            </h1>
            <p className="text-base sm:text-lg text-gray-600 dark:text-gray-400 px-4">
              Choose your role to get started
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
                  Book amazing activities and experiences in Egypt
                </p>
                <div className="text-teal-500 group-hover:text-teal-600 transition-colors">
                  Register as Customer →
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
                  Manage customers and their travel activities
                </p>
                <div className="text-orange-500 group-hover:text-orange-600 transition-colors">
                  Register as Representative →
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
                  Provide services and manage trip bookings
                </p>
                <div className="text-purple-500 group-hover:text-purple-600 transition-colors">
                  Register as Supplier →
                </div>
              </div>
            </button>
          </div>

          {/* Login Link */}
          <div className="text-center">
            <p className="text-sm sm:text-base text-gray-600 dark:text-gray-400">
              Already have an account?{' '}
              <button
                onClick={onSwitchToLogin}
                className="text-teal-600 dark:text-teal-400 hover:text-teal-700 dark:hover:text-teal-300 transition-colors"
              >
                Login Here
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
    <div className="min-h-screen flex items-center justify-center p-4 py-8 sm:py-12">
      <div className="w-full max-w-md">
        {/* Back Button */}
        <button
          onClick={() => setSelectedRole(null)}
          className="mb-6 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors flex items-center space-x-2"
        >
          <span>←</span>
          <span>Back to role selection</span>
        </button>

        {/* Register Card */}
        <div className="bg-white dark:bg-gray-800 rounded-2xl shadow-2xl p-6 sm:p-8">
          {/* Header */}
          <div className="text-center mb-6 sm:mb-8">
            <div className={`w-16 h-16 bg-gradient-to-br ${getRoleColor()} rounded-2xl flex items-center justify-center mx-auto mb-4 shadow-lg`}>
              {getRoleIcon()}
            </div>
            <h2 className="text-2xl sm:text-3xl text-gray-900 dark:text-white mb-2">
              Register as {selectedRole?.charAt(0).toUpperCase() + selectedRole?.slice(1)}
            </h2>
            <p className="text-sm sm:text-base text-gray-600 dark:text-gray-400">
              Create your account to get started
            </p>
          </div>

          {/* Social Register for Customers */}
          {showSocialRegister && (
            <div className="space-y-3 mb-6">
              <button
                onClick={() => handleSocialRegister('google')}
                className="w-full bg-white dark:bg-gray-700 border-2 border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-200 py-3 rounded-xl hover:bg-gray-50 dark:hover:bg-gray-600 transition-all shadow-md hover:shadow-lg flex items-center justify-center space-x-3"
              >
                <span className="text-xl">🔍</span>
                <span>Continue with Google</span>
              </button>
              <button
                onClick={() => handleSocialRegister('apple')}
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
                    Or register with email
                  </span>
                </div>
              </div>
            </div>
          )}

          {/* Register Form */}
          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label className="block text-sm text-gray-700 dark:text-gray-300 mb-2">
                Full Name
              </label>
              <div className="relative">
                <User className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
                <input
                  type="text"
                  name="fullName"
                  value={formData.fullName}
                  onChange={handleChange}
                  placeholder="John Doe"
                  required
                  className="w-full pl-11 pr-4 py-3 rounded-xl border-2 border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-gray-500 focus:ring-2 focus:ring-teal-500 focus:border-transparent transition-all"
                />
              </div>
            </div>

            <div>
              <label className="block text-sm text-gray-700 dark:text-gray-300 mb-2">
                Email Address
              </label>
              <div className="relative">
                <Mail className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
                <input
                  type="email"
                  name="email"
                  value={formData.email}
                  onChange={handleChange}
                  placeholder="you@example.com"
                  required
                  className="w-full pl-11 pr-4 py-3 rounded-xl border-2 border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-gray-500 focus:ring-2 focus:ring-teal-500 focus:border-transparent transition-all"
                />
              </div>
            </div>

            <div>
              <label className="block text-sm text-gray-700 dark:text-gray-300 mb-2">
                Phone Number
              </label>
              <div className="relative">
                <Phone className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
                <input
                  type="tel"
                  name="phone"
                  value={formData.phone}
                  onChange={handleChange}
                  placeholder="+20 123 456 7890"
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
                  name="password"
                  value={formData.password}
                  onChange={handleChange}
                  placeholder="••••••••"
                  required
                  className="w-full pl-11 pr-4 py-3 rounded-xl border-2 border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-gray-500 focus:ring-2 focus:ring-teal-500 focus:border-transparent transition-all"
                />
              </div>
            </div>

            <div>
              <label className="block text-sm text-gray-700 dark:text-gray-300 mb-2">
                Confirm Password
              </label>
              <div className="relative">
                <Lock className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
                <input
                  type="password"
                  name="confirmPassword"
                  value={formData.confirmPassword}
                  onChange={handleChange}
                  placeholder="••••••••"
                  required
                  className="w-full pl-11 pr-4 py-3 rounded-xl border-2 border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-gray-500 focus:ring-2 focus:ring-teal-500 focus:border-transparent transition-all"
                />
              </div>
            </div>

            <div className="flex items-start space-x-2">
              <input
                type="checkbox"
                required
                className="w-4 h-4 mt-1 rounded border-gray-300 text-teal-500 focus:ring-teal-500"
              />
              <label className="text-sm text-gray-600 dark:text-gray-400">
                I agree to the{' '}
                <button type="button" className="text-teal-600 dark:text-teal-400 hover:text-teal-700 dark:hover:text-teal-300">
                  Terms of Service
                </button>{' '}
                and{' '}
                <button type="button" className="text-teal-600 dark:text-teal-400 hover:text-teal-700 dark:hover:text-teal-300">
                  Privacy Policy
                </button>
              </label>
            </div>

            <button
              type="submit"
              className={`w-full bg-gradient-to-r ${getRoleColor()} text-white py-3 rounded-xl hover:shadow-lg transition-all duration-300 transform hover:scale-105`}
            >
              Create Account
            </button>
          </form>

          {/* Login Link */}
          <div className="mt-6 text-center">
            <p className="text-sm text-gray-600 dark:text-gray-400">
              Already have an account?{' '}
              <button
                onClick={onSwitchToLogin}
                className="text-teal-600 dark:text-teal-400 hover:text-teal-700 dark:hover:text-teal-300 transition-colors"
              >
                Login Here
              </button>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}

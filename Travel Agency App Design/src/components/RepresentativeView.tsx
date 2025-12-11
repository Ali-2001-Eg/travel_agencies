import { useState } from 'react';
import { Users, TrendingUp, Calendar, Eye, CheckCircle, Clock, MapPin } from 'lucide-react';

interface RepresentativeViewProps {
  isDarkMode: boolean;
  language: string;
  userName: string;
}

interface Customer {
  id: number;
  name: string;
  avatar: string;
  connectedDate: string;
  totalBookings: number;
  status: 'active' | 'inactive';
}

interface CustomerActivity {
  id: number;
  customerName: string;
  activity: string;
  location: string;
  date: string;
  time: string;
  status: 'confirmed' | 'pending' | 'completed';
  price: number;
}

export function RepresentativeView({ isDarkMode, language, userName }: RepresentativeViewProps) {
  const [selectedFilter, setSelectedFilter] = useState('all');

  const customers: Customer[] = [
    { id: 1, name: 'John Doe', avatar: 'JD', connectedDate: '2025-11-20', totalBookings: 5, status: 'active' },
    { id: 2, name: 'Sarah Smith', avatar: 'SS', connectedDate: '2025-11-22', totalBookings: 3, status: 'active' },
    { id: 3, name: 'Michael Chen', avatar: 'MC', connectedDate: '2025-11-25', totalBookings: 7, status: 'active' },
    { id: 4, name: 'Emma Wilson', avatar: 'EW', connectedDate: '2025-11-18', totalBookings: 4, status: 'inactive' },
    { id: 5, name: 'David Brown', avatar: 'DB', connectedDate: '2025-11-26', totalBookings: 2, status: 'active' },
  ];

  const activities: CustomerActivity[] = [
    {
      id: 1,
      customerName: 'John Doe',
      activity: 'Red Sea Snorkeling',
      location: 'Sharm El Sheikh',
      date: '2025-12-05',
      time: '09:00 AM',
      status: 'confirmed',
      price: 45,
    },
    {
      id: 2,
      customerName: 'Sarah Smith',
      activity: 'Desert Safari Adventure',
      location: 'Hurghada',
      date: '2025-12-08',
      time: '03:00 PM',
      status: 'confirmed',
      price: 65,
    },
    {
      id: 3,
      customerName: 'Michael Chen',
      activity: 'Luxor Temple Tour',
      location: 'Luxor',
      date: '2025-12-10',
      time: '07:00 AM',
      status: 'pending',
      price: 55,
    },
    {
      id: 4,
      customerName: 'John Doe',
      activity: 'Scuba Diving Experience',
      location: 'Hurghada',
      date: '2025-12-12',
      time: '10:00 AM',
      status: 'confirmed',
      price: 85,
    },
    {
      id: 5,
      customerName: 'Emma Wilson',
      activity: 'Night Club Experience',
      location: 'Sharm El Sheikh',
      date: '2025-11-28',
      time: '10:00 PM',
      status: 'completed',
      price: 40,
    },
    {
      id: 6,
      customerName: 'David Brown',
      activity: 'Bedouin Safari Night',
      location: 'Sharm El Sheikh',
      date: '2025-12-15',
      time: '04:00 PM',
      status: 'pending',
      price: 50,
    },
    {
      id: 7,
      customerName: 'Michael Chen',
      activity: 'Christmas Beach Party',
      location: 'Sharm El Sheikh',
      date: '2025-12-25',
      time: '08:00 PM',
      status: 'confirmed',
      price: 75,
    },
    {
      id: 8,
      customerName: 'Sarah Smith',
      activity: 'Spa & Massage Service',
      location: 'Hurghada',
      date: '2025-12-06',
      time: '02:00 PM',
      status: 'confirmed',
      price: 60,
    },
  ];

  const filteredActivities = selectedFilter === 'all' 
    ? activities 
    : activities.filter(activity => activity.status === selectedFilter);

  const stats = {
    totalCustomers: customers.filter(c => c.status === 'active').length,
    totalBookings: activities.length,
    pendingActivities: activities.filter(a => a.status === 'pending').length,
    totalRevenue: activities.reduce((sum, a) => sum + a.price, 0),
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'confirmed':
        return 'bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-400';
      case 'pending':
        return 'bg-yellow-100 dark:bg-yellow-900/30 text-yellow-700 dark:text-yellow-400';
      case 'completed':
        return 'bg-blue-100 dark:bg-blue-900/30 text-blue-700 dark:text-blue-400';
      default:
        return 'bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-400';
    }
  };

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 sm:py-8">
      {/* Header */}
      <div className="mb-6 sm:mb-8">
        <h1 className="text-2xl sm:text-3xl lg:text-4xl text-gray-900 dark:text-white mb-2">
          Representative Dashboard
        </h1>
        <p className="text-sm sm:text-base text-gray-600 dark:text-gray-400">
          Monitor your customers' activities and bookings
        </p>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-6 mb-6 sm:mb-8">
        <div className="bg-gradient-to-br from-orange-500 to-orange-600 rounded-2xl p-6 text-white shadow-lg hover:shadow-xl transition-all">
          <div className="flex items-center justify-between mb-2">
            <Users className="w-7 h-7 sm:w-8 sm:h-8 opacity-80" />
            <span className="text-2xl sm:text-3xl">{stats.totalCustomers}</span>
          </div>
          <p className="text-orange-100 text-sm sm:text-base">Active Customers</p>
        </div>

        <div className="bg-gradient-to-br from-teal-500 to-teal-600 rounded-2xl p-6 text-white shadow-lg hover:shadow-xl transition-all">
          <div className="flex items-center justify-between mb-2">
            <CheckCircle className="w-7 h-7 sm:w-8 sm:h-8 opacity-80" />
            <span className="text-2xl sm:text-3xl">{stats.totalBookings}</span>
          </div>
          <p className="text-teal-100 text-sm sm:text-base">Total Bookings</p>
        </div>

        <div className="bg-gradient-to-br from-amber-500 to-amber-600 rounded-2xl p-6 text-white shadow-lg hover:shadow-xl transition-all">
          <div className="flex items-center justify-between mb-2">
            <Clock className="w-7 h-7 sm:w-8 sm:h-8 opacity-80" />
            <span className="text-2xl sm:text-3xl">{stats.pendingActivities}</span>
          </div>
          <p className="text-amber-100 text-sm sm:text-base">Pending Activities</p>
        </div>

        <div className="bg-gradient-to-br from-purple-500 to-purple-600 rounded-2xl p-6 text-white shadow-lg hover:shadow-xl transition-all">
          <div className="flex items-center justify-between mb-2">
            <TrendingUp className="w-7 h-7 sm:w-8 sm:h-8 opacity-80" />
            <span className="text-2xl sm:text-3xl">${stats.totalRevenue}</span>
          </div>
          <p className="text-purple-100 text-sm sm:text-base">Total Revenue</p>
        </div>
      </div>

      {/* My Customers */}
      <section className="mb-6 sm:mb-8">
        <h2 className="text-xl sm:text-2xl text-gray-900 dark:text-white mb-4 sm:mb-6">My Customers</h2>
        <div className="bg-white dark:bg-gray-800 rounded-2xl shadow-lg overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-gray-50 dark:bg-gray-900">
                <tr>
                  <th className="px-6 py-4 text-left text-xs text-gray-600 dark:text-gray-400 uppercase tracking-wider">
                    Customer
                  </th>
                  <th className="px-6 py-4 text-left text-xs text-gray-600 dark:text-gray-400 uppercase tracking-wider">
                    Connected Date
                  </th>
                  <th className="px-6 py-4 text-left text-xs text-gray-600 dark:text-gray-400 uppercase tracking-wider">
                    Total Bookings
                  </th>
                  <th className="px-6 py-4 text-left text-xs text-gray-600 dark:text-gray-400 uppercase tracking-wider">
                    Status
                  </th>
                  <th className="px-6 py-4 text-left text-xs text-gray-600 dark:text-gray-400 uppercase tracking-wider">
                    Actions
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200 dark:divide-gray-700">
                {customers.map((customer) => (
                  <tr key={customer.id} className="hover:bg-gray-50 dark:hover:bg-gray-700/50 transition-colors">
                    <td className="px-4 sm:px-6 py-4">
                      <div className="flex items-center space-x-3">
                        <div className="w-10 h-10 bg-gradient-to-br from-orange-500 to-orange-600 rounded-full flex items-center justify-center text-white text-sm">
                          {customer.avatar}
                        </div>
                        <span className="text-sm sm:text-base text-gray-900 dark:text-white">{customer.name}</span>
                      </div>
                    </td>
                    <td className="px-6 py-4 text-gray-600 dark:text-gray-400">
                      {customer.connectedDate}
                    </td>
                    <td className="px-6 py-4 text-gray-900 dark:text-white">
                      {customer.totalBookings}
                    </td>
                    <td className="px-6 py-4">
                      <span
                        className={`px-3 py-1 rounded-full text-sm ${
                          customer.status === 'active'
                            ? 'bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-400'
                            : 'bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-400'
                        }`}
                      >
                        {customer.status}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <button className="text-blue-500 hover:text-blue-600 dark:text-blue-400 dark:hover:text-blue-300 flex items-center space-x-1">
                        <Eye className="w-4 h-4" />
                        <span className="text-sm">View Details</span>
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </section>

      {/* Customer Activities */}
      <section>
        <div className="flex flex-col sm:flex-row sm:items-center justify-between mb-4 sm:mb-6 gap-4">
          <h2 className="text-xl sm:text-2xl text-gray-900 dark:text-white">Customer Activities</h2>
          <div className="flex flex-wrap gap-2">
            <button
              onClick={() => setSelectedFilter('all')}
              className={`px-3 sm:px-4 py-2 rounded-xl transition-all text-sm sm:text-base ${
                selectedFilter === 'all'
                  ? 'bg-gradient-to-r from-orange-500 to-orange-600 text-white shadow-lg'
                  : 'bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600'
              }`}
            >
              All
            </button>
            <button
              onClick={() => setSelectedFilter('pending')}
              className={`px-3 sm:px-4 py-2 rounded-xl transition-all text-sm sm:text-base ${
                selectedFilter === 'pending'
                  ? 'bg-gradient-to-r from-orange-500 to-orange-600 text-white shadow-lg'
                  : 'bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600'
              }`}
            >
              Pending
            </button>
            <button
              onClick={() => setSelectedFilter('confirmed')}
              className={`px-3 sm:px-4 py-2 rounded-xl transition-all text-sm sm:text-base ${
                selectedFilter === 'confirmed'
                  ? 'bg-gradient-to-r from-orange-500 to-orange-600 text-white shadow-lg'
                  : 'bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600'
              }`}
            >
              Confirmed
            </button>
            <button
              onClick={() => setSelectedFilter('completed')}
              className={`px-3 sm:px-4 py-2 rounded-xl transition-all text-sm sm:text-base ${
                selectedFilter === 'completed'
                  ? 'bg-gradient-to-r from-orange-500 to-orange-600 text-white shadow-lg'
                  : 'bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600'
              }`}
            >
              Completed
            </button>
          </div>
        </div>

        <div className="space-y-4">
          {filteredActivities.map((activity) => (
            <div
              key={activity.id}
              className="bg-white dark:bg-gray-800 rounded-2xl shadow-lg p-4 sm:p-6 hover:shadow-xl transition-all"
            >
              <div className="flex flex-col md:flex-row md:items-center md:justify-between">
                <div className="flex-1 mb-4 md:mb-0">
                  <div className="flex items-center space-x-3 mb-2">
                    <div className="w-8 h-8 bg-gradient-to-br from-orange-500 to-orange-600 rounded-full flex items-center justify-center text-white text-xs">
                      {activity.customerName.split(' ').map(n => n[0]).join('')}
                    </div>
                    <h3 className="text-lg sm:text-xl text-gray-900 dark:text-white">{activity.activity}</h3>
                  </div>
                  <p className="text-gray-600 dark:text-gray-400 mb-2">Customer: {activity.customerName}</p>
                  <div className="flex flex-wrap gap-4 text-sm text-gray-600 dark:text-gray-400">
                    <div className="flex items-center space-x-1">
                      <MapPin className="w-4 h-4" />
                      <span>{activity.location}</span>
                    </div>
                    <div className="flex items-center space-x-1">
                      <Calendar className="w-4 h-4" />
                      <span>{activity.date}</span>
                    </div>
                    <div className="flex items-center space-x-1">
                      <Clock className="w-4 h-4" />
                      <span>{activity.time}</span>
                    </div>
                  </div>
                </div>
                <div className="flex items-center space-x-4">
                  <div className="text-right">
                    <p className="text-2xl text-gray-900 dark:text-white">${activity.price}</p>
                    <span className={`px-3 py-1 rounded-full text-sm inline-block mt-1 ${getStatusColor(activity.status)}`}>
                      {activity.status}
                    </span>
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>
      </section>
    </div>
  );
}

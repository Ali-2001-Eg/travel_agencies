import { useState } from 'react';
import { Package, Users, MapPin, Calendar, Clock, Check, X, AlertCircle } from 'lucide-react';

interface SupplierViewProps {
  isDarkMode: boolean;
  language: string;
  userName: string;
}

interface TripRequest {
  id: number;
  activity: string;
  location: string;
  date: string;
  time: string;
  participants: number;
  pricePerPerson: number;
  totalPrice: number;
  status: 'pending' | 'accepted' | 'rejected';
  requestedDate: string;
  representative: string;
  category: string;
}

export function SupplierView({ isDarkMode, language, userName }: SupplierViewProps) {
  const [trips, setTrips] = useState<TripRequest[]>([
    {
      id: 1,
      activity: 'Desert Safari Adventure',
      location: 'Hurghada',
      date: '2025-12-08',
      time: '03:00 PM',
      participants: 15,
      pricePerPerson: 65,
      totalPrice: 975,
      status: 'pending',
      requestedDate: '2025-11-28',
      representative: 'Ahmed Hassan',
      category: 'Safari',
    },
    {
      id: 2,
      activity: 'Red Sea Snorkeling',
      location: 'Sharm El Sheikh',
      date: '2025-12-05',
      time: '09:00 AM',
      participants: 8,
      pricePerPerson: 45,
      totalPrice: 360,
      status: 'pending',
      requestedDate: '2025-11-27',
      representative: 'Ahmed Hassan',
      category: 'Water Sports',
    },
    {
      id: 3,
      activity: 'Luxor Temple Tour',
      location: 'Luxor',
      date: '2025-12-10',
      time: '07:00 AM',
      participants: 12,
      pricePerPerson: 55,
      totalPrice: 660,
      status: 'pending',
      requestedDate: '2025-11-28',
      representative: 'Mohamed Ali',
      category: 'Cultural',
    },
    {
      id: 4,
      activity: 'Scuba Diving Experience',
      location: 'Hurghada',
      date: '2025-12-12',
      time: '10:00 AM',
      participants: 6,
      pricePerPerson: 85,
      totalPrice: 510,
      status: 'accepted',
      requestedDate: '2025-11-26',
      representative: 'Ahmed Hassan',
      category: 'Diving',
    },
    {
      id: 5,
      activity: 'Night Club Experience',
      location: 'Sharm El Sheikh',
      date: '2025-12-06',
      time: '10:00 PM',
      participants: 20,
      pricePerPerson: 40,
      totalPrice: 800,
      status: 'accepted',
      requestedDate: '2025-11-25',
      representative: 'Sara Mohamed',
      category: 'Night Life',
    },
    {
      id: 6,
      activity: 'Bedouin Safari Night',
      location: 'Sharm El Sheikh',
      date: '2025-12-15',
      time: '04:00 PM',
      participants: 10,
      pricePerPerson: 50,
      totalPrice: 500,
      status: 'pending',
      requestedDate: '2025-11-28',
      representative: 'Ahmed Hassan',
      category: 'Safari',
    },
    {
      id: 7,
      activity: 'Christmas Beach Party',
      location: 'Sharm El Sheikh',
      date: '2025-12-25',
      time: '08:00 PM',
      participants: 25,
      pricePerPerson: 75,
      totalPrice: 1875,
      status: 'pending',
      requestedDate: '2025-11-28',
      representative: 'Multiple',
      category: 'Events',
    },
  ]);

  const [selectedFilter, setSelectedFilter] = useState<'all' | 'pending' | 'accepted' | 'rejected'>('pending');

  const handleAccept = (id: number) => {
    setTrips(trips.map(trip => 
      trip.id === id ? { ...trip, status: 'accepted' as const } : trip
    ));
  };

  const handleReject = (id: number) => {
    setTrips(trips.map(trip => 
      trip.id === id ? { ...trip, status: 'rejected' as const } : trip
    ));
  };

  const filteredTrips = selectedFilter === 'all' 
    ? trips 
    : trips.filter(trip => trip.status === selectedFilter);

  const stats = {
    pendingRequests: trips.filter(t => t.status === 'pending').length,
    acceptedTrips: trips.filter(t => t.status === 'accepted').length,
    totalParticipants: trips.filter(t => t.status === 'accepted').reduce((sum, t) => sum + t.participants, 0),
    totalRevenue: trips.filter(t => t.status === 'accepted').reduce((sum, t) => sum + t.totalPrice, 0),
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'accepted':
        return 'bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-400';
      case 'pending':
        return 'bg-yellow-100 dark:bg-yellow-900/30 text-yellow-700 dark:text-yellow-400';
      case 'rejected':
        return 'bg-red-100 dark:bg-red-900/30 text-red-700 dark:text-red-400';
      default:
        return 'bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-400';
    }
  };

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 sm:py-8">
      {/* Header */}
      <div className="mb-6 sm:mb-8">
        <h1 className="text-2xl sm:text-3xl lg:text-4xl text-gray-900 dark:text-white mb-2">
          Supplier Dashboard
        </h1>
        <p className="text-sm sm:text-base text-gray-600 dark:text-gray-400">
          Manage trip requests and bookings from representatives
        </p>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-6 mb-6 sm:mb-8">
        <div className="bg-gradient-to-br from-amber-500 to-amber-600 rounded-2xl p-6 text-white shadow-lg hover:shadow-xl transition-all">
          <div className="flex items-center justify-between mb-2">
            <AlertCircle className="w-7 h-7 sm:w-8 sm:h-8 opacity-80" />
            <span className="text-2xl sm:text-3xl">{stats.pendingRequests}</span>
          </div>
          <p className="text-amber-100 text-sm sm:text-base">Pending Requests</p>
        </div>

        <div className="bg-gradient-to-br from-teal-500 to-teal-600 rounded-2xl p-6 text-white shadow-lg hover:shadow-xl transition-all">
          <div className="flex items-center justify-between mb-2">
            <Check className="w-7 h-7 sm:w-8 sm:h-8 opacity-80" />
            <span className="text-2xl sm:text-3xl">{stats.acceptedTrips}</span>
          </div>
          <p className="text-teal-100 text-sm sm:text-base">Accepted Trips</p>
        </div>

        <div className="bg-gradient-to-br from-orange-500 to-orange-600 rounded-2xl p-6 text-white shadow-lg hover:shadow-xl transition-all">
          <div className="flex items-center justify-between mb-2">
            <Users className="w-7 h-7 sm:w-8 sm:h-8 opacity-80" />
            <span className="text-2xl sm:text-3xl">{stats.totalParticipants}</span>
          </div>
          <p className="text-orange-100 text-sm sm:text-base">Total Participants</p>
        </div>

        <div className="bg-gradient-to-br from-purple-500 to-purple-600 rounded-2xl p-6 text-white shadow-lg hover:shadow-xl transition-all">
          <div className="flex items-center justify-between mb-2">
            <Package className="w-7 h-7 sm:w-8 sm:h-8 opacity-80" />
            <span className="text-2xl sm:text-3xl">${stats.totalRevenue}</span>
          </div>
          <p className="text-purple-100 text-sm sm:text-base">Total Revenue</p>
        </div>
      </div>

      {/* Filters */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between mb-4 sm:mb-6 gap-4">
        <h2 className="text-xl sm:text-2xl text-gray-900 dark:text-white">Trip Requests</h2>
        <div className="flex flex-wrap gap-2">
          <button
            onClick={() => setSelectedFilter('all')}
            className={`px-3 sm:px-4 py-2 rounded-xl transition-all text-sm sm:text-base ${
              selectedFilter === 'all'
                ? 'bg-gradient-to-r from-purple-500 to-purple-600 text-white shadow-lg'
                : 'bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600'
            }`}
          >
            All
          </button>
          <button
            onClick={() => setSelectedFilter('pending')}
            className={`px-3 sm:px-4 py-2 rounded-xl transition-all text-sm sm:text-base ${
              selectedFilter === 'pending'
                ? 'bg-gradient-to-r from-purple-500 to-purple-600 text-white shadow-lg'
                : 'bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600'
            }`}
          >
            Pending
          </button>
          <button
            onClick={() => setSelectedFilter('accepted')}
            className={`px-3 sm:px-4 py-2 rounded-xl transition-all text-sm sm:text-base ${
              selectedFilter === 'accepted'
                ? 'bg-gradient-to-r from-purple-500 to-purple-600 text-white shadow-lg'
                : 'bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600'
            }`}
          >
            Accepted
          </button>
          <button
            onClick={() => setSelectedFilter('rejected')}
            className={`px-3 sm:px-4 py-2 rounded-xl transition-all text-sm sm:text-base ${
              selectedFilter === 'rejected'
                ? 'bg-gradient-to-r from-purple-500 to-purple-600 text-white shadow-lg'
                : 'bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600'
            }`}
          >
            Rejected
          </button>
        </div>
      </div>

      {/* Trip Requests */}
      <div className="space-y-4">
        {filteredTrips.map((trip) => (
          <div
            key={trip.id}
            className="bg-white dark:bg-gray-800 rounded-2xl shadow-lg overflow-hidden hover:shadow-xl transition-all"
          >
            <div className="p-4 sm:p-6">
              <div className="flex flex-col lg:flex-row lg:items-start lg:justify-between gap-6">
                {/* Left Section */}
                <div className="flex-1">
                  <div className="flex items-start justify-between mb-4">
                    <div>
                      <h3 className="text-xl sm:text-2xl text-gray-900 dark:text-white mb-2">{trip.activity}</h3>
                      <span className="px-3 py-1 rounded-full text-xs sm:text-sm bg-gradient-to-r from-purple-500/20 to-purple-600/20 text-purple-700 dark:text-purple-400 border border-purple-300 dark:border-purple-600">
                        {trip.category}
                      </span>
                    </div>
                    <span className={`px-4 py-2 rounded-full text-sm ${getStatusColor(trip.status)}`}>
                      {trip.status.charAt(0).toUpperCase() + trip.status.slice(1)}
                    </span>
                  </div>

                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                    <div className="flex items-center space-x-2 text-gray-600 dark:text-gray-400">
                      <MapPin className="w-5 h-5" />
                      <span>{trip.location}</span>
                    </div>
                    <div className="flex items-center space-x-2 text-gray-600 dark:text-gray-400">
                      <Calendar className="w-5 h-5" />
                      <span>{trip.date}</span>
                    </div>
                    <div className="flex items-center space-x-2 text-gray-600 dark:text-gray-400">
                      <Clock className="w-5 h-5" />
                      <span>{trip.time}</span>
                    </div>
                    <div className="flex items-center space-x-2 text-gray-600 dark:text-gray-400">
                      <Users className="w-5 h-5" />
                      <span>{trip.participants} Participants</span>
                    </div>
                  </div>

                  <div className="bg-gray-50 dark:bg-gray-900 rounded-lg p-4">
                    <div className="grid grid-cols-2 gap-4">
                      <div>
                        <p className="text-sm text-gray-500 dark:text-gray-400 mb-1">Representative</p>
                        <p className="text-gray-900 dark:text-white">{trip.representative}</p>
                      </div>
                      <div>
                        <p className="text-sm text-gray-500 dark:text-gray-400 mb-1">Requested Date</p>
                        <p className="text-gray-900 dark:text-white">{trip.requestedDate}</p>
                      </div>
                      <div>
                        <p className="text-sm text-gray-500 dark:text-gray-400 mb-1">Price Per Person</p>
                        <p className="text-gray-900 dark:text-white text-xl">${trip.pricePerPerson}</p>
                      </div>
                      <div>
                        <p className="text-sm text-gray-500 dark:text-gray-400 mb-1">Total Price</p>
                        <p className="text-gray-900 dark:text-white text-xl">${trip.totalPrice}</p>
                      </div>
                    </div>
                  </div>
                </div>

                {/* Right Section - Actions */}
                {trip.status === 'pending' && (
                  <div className="flex lg:flex-col gap-3">
                    <button
                      onClick={() => handleAccept(trip.id)}
                      className="flex-1 lg:flex-none bg-gradient-to-r from-teal-500 to-teal-600 text-white px-6 py-3 rounded-xl hover:shadow-lg transition-all flex items-center justify-center space-x-2"
                    >
                      <Check className="w-5 h-5" />
                      <span>Accept</span>
                    </button>
                    <button
                      onClick={() => handleReject(trip.id)}
                      className="flex-1 lg:flex-none bg-gradient-to-r from-red-500 to-red-600 text-white px-6 py-3 rounded-xl hover:shadow-lg transition-all flex items-center justify-center space-x-2"
                    >
                      <X className="w-5 h-5" />
                      <span>Reject</span>
                    </button>
                  </div>
                )}
                
                {trip.status === 'accepted' && (
                  <div className="flex items-center justify-center lg:justify-start">
                    <div className="bg-teal-100 dark:bg-teal-900/30 text-teal-700 dark:text-teal-400 px-4 sm:px-6 py-3 rounded-xl flex items-center space-x-2 text-sm sm:text-base">
                      <Check className="w-5 h-5" />
                      <span className="hidden sm:inline">Confirmed & Visible to Customers</span>
                      <span className="sm:hidden">Confirmed</span>
                    </div>
                  </div>
                )}

                {trip.status === 'rejected' && (
                  <div className="flex items-center justify-center lg:justify-start">
                    <div className="bg-red-100 dark:bg-red-900/30 text-red-700 dark:text-red-400 px-4 sm:px-6 py-3 rounded-xl flex items-center space-x-2 text-sm sm:text-base">
                      <X className="w-5 h-5" />
                      <span>Request Declined</span>
                    </div>
                  </div>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>

      {filteredTrips.length === 0 && (
        <div className="bg-white dark:bg-gray-800 rounded-2xl shadow-lg p-8 sm:p-12 text-center">
          <Package className="w-12 h-12 sm:w-16 sm:h-16 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg sm:text-xl text-gray-900 dark:text-white mb-2">No trip requests found</h3>
          <p className="text-sm sm:text-base text-gray-600 dark:text-gray-400">
            {selectedFilter === 'pending' && 'No pending requests at the moment'}
            {selectedFilter === 'accepted' && 'No accepted trips yet'}
            {selectedFilter === 'rejected' && 'No rejected requests'}
          </p>
        </div>
      )}
    </div>
  );
}
